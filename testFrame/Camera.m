//
//  WTSARCamera.m
//  YangDongXi
//
//  Created by xianhuanlin on 2017/10/25.
//  Copyright © 2017年 Watsons. All rights reserved.
//

#import "Camera.h"
#import <CoreVideo/CVHostTime.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <pthread.h>
#import <Availability.h>

#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>


@interface WTSARCamera ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, readonly) BOOL isOpen;
@property (nonatomic, assign) AVCaptureDevicePosition position;
@property (nonatomic, readonly, strong) AVCaptureSession *session;

@end



@implementation WTSARCamera {
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    NSString    *_captureType;
    BOOL _isOpen;
    AVCaptureVideoDataOutput *_dataOutput;
    AVCaptureVideoPreviewLayer *previewLayer;
    
    pthread_mutex_t frameLock_pthread_mutex;
    OSType pixelFormat;
    size_t planeCount;
    cameraVideoBuf_t *planes;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _position = AVCaptureDevicePositionBack;
    }
    return self;
}


- (void)dealloc {
    [self stop];
}

- (void)open {
    if (_isOpen) {
        NSLog(@"Capture is already opened.");
        return;
    }
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *td = nil;
    _device = nil;
    for (AVCaptureDevice *device in devices) {
        if (device.position == _position) {
            td = device;
            break;
        }
    }
    
    if (td) {
        NSError *err = nil;
        _input = [AVCaptureDeviceInput deviceInputWithDevice:td error:&err];
        
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetHigh;
        
        if ([_session canAddInput:_input]) {
            [_session addInput:_input];
            [_session startRunning];
            _isOpen = YES;
            _device = td;
            
            _dataOutput = [[AVCaptureVideoDataOutput alloc] init];
            [_dataOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey:
                                                [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]}];
            [_dataOutput setSampleBufferDelegate:self
                                           queue:dispatch_get_main_queue()];
            
            if ([_session canAddOutput:_dataOutput]) {
                [_session addOutput:_dataOutput];
            }
        }
    }
}

- (void)start {
    if (_isOpen) {
        NSLog(@"Capture is already opened.");
        return;
    }
    //_captureType
    [self open];
}

- (void)stop {
    if (!_isOpen) return;
    [_session stopRunning];
    [_session removeInput:_input];
    _session = nil;
    _input = nil;
    _device = nil;
    _isOpen = NO;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    pthread_mutex_lock(&frameLock_pthread_mutex);
    
    if (!planes) {
        pixelFormat = CVPixelBufferGetPixelFormatType(imageBuffer);
        
        size_t pixelSize = 1;

        if (pixelSize) {
            planeCount = CVPixelBufferGetPlaneCount(imageBuffer);
            if (!planeCount) {
                planes = (cameraVideoBuf_t *)calloc(sizeof(cameraVideoBuf_t), 1);
                planes[0].bytesPerRowSrc = CVPixelBufferGetBytesPerRow(imageBuffer);
                planes[0].width = CVPixelBufferGetWidth(imageBuffer);
                planes[0].height = CVPixelBufferGetHeight(imageBuffer);
                planes[0].bytesPerRow = planes[0].width * pixelSize;
                planes[0].bufDataPtr0 = (unsigned char *)valloc(planes[0].height*planes[0].bytesPerRow);
                planes[0].bufDataPtr1 = (unsigned char *)valloc(planes[0].height*planes[0].bytesPerRow);
                if (!planes[0].bufDataPtr0 || !planes[0].bufDataPtr1) {
                    NSLog(@"Error: Out of memory!\n");
                }
            } else {
                planes = (cameraVideoBuf_t *)calloc(sizeof(cameraVideoBuf_t), planeCount);
                for (unsigned int i = 0; i < planeCount; i++) {
                    planes[i].bytesPerRowSrc = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, i);
                    planes[i].width = CVPixelBufferGetWidthOfPlane(imageBuffer, i);
                    planes[i].height = CVPixelBufferGetHeightOfPlane(imageBuffer, i);
                    if (i == 0) planes[i].bytesPerRow = planes[i].width * pixelSize;
                    else if (i == 1) planes[i].bytesPerRow = planes[i].width * 2;
                    planes[i].bufDataPtr0 = (unsigned char *)valloc(planes[i].height*planes[i].bytesPerRow);
                    planes[i].bufDataPtr1 = (unsigned char *)valloc(planes[i].height*planes[i].bytesPerRow);
                    if (!planes[i].bufDataPtr0 || !planes[i].bufDataPtr1) {
                        NSLog(@"Error: Out of memory!\n");
                    }
                }
            }

        }
    }
    
    uint8_t *srcAddress, *destAddress;
    
    CVPixelBufferLockBaseAddress(imageBuffer, kCVPixelBufferLock_ReadOnly);
    
    if (planeCount)
    {
        for (unsigned int i = 0; i < planeCount; i++) {
            srcAddress = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, i);
            destAddress = (planes[i].bufDataPtr1);
            if (planes[i].bytesPerRow == planes[i].bytesPerRowSrc) memcpy(destAddress, srcAddress, planes[i].height*planes[i].bytesPerRow);
            else for (int r = 0; r < planes[i].height; r++) memcpy(destAddress + r*planes[i].bytesPerRow, srcAddress + r*planes[i].bytesPerRowSrc, planes[i].bytesPerRow);
        }
    }
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, kCVPixelBufferLock_ReadOnly);
    
    
    pthread_mutex_unlock(&frameLock_pthread_mutex);
    
    if (self.onCameraVideo){
        self.onCameraVideo(planes);
    }
    
    //if (tookPictureDelegate) [tookPictureDelegate cameraVideoTookPicture:self userData:tookPictureDelegateUserData];
}
- (void)attachToView:(UIView *)view{
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = view.bounds;
    [view.layer addSublayer:previewLayer];
}

@end

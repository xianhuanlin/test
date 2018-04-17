//
//  WTSARCamera.h
//  YangDongXi
//
//  Created by xianhuanlin on 2017/10/25.
//  Copyright © 2017年 Watsons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef struct {
    size_t width;
    size_t height;
    OSType pixelFormat;
    unsigned char *bufDataPtr0;
    unsigned char *bufDataPtr1;
    size_t bytesPerRow;
    size_t bytesPerRowSrc;
} cameraVideoBuf_t;

@interface WTSARCameraData:NSObject



@end

@interface WTSARCamera : NSObject

- (void)attachToView:(UIView*)view;

- (void)start;

- (void)stop;

- (void)onVideoCame:(WTSARCameraData*)data;

@property (nonatomic,copy) void (^onCameraVideo)(cameraVideoBuf_t *buf) ;

@end

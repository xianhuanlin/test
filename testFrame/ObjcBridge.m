//
//  ObjcBridge.m
//  testFrame
//
//  Created by xianhuanlin on 2017/8/30.
//  Copyright © 2017年 xianhuanlin. All rights reserved.
//

#import "ObjcBridge.h"
#import "SSZipArchive.h"
#import <WeexSDK/WeexSDK.h>
#import "ImageHandler.h"
#import "navhandler.h"
#import "protocol.h"

@implementation ObjcBridge{
    NSString* _fileRootPath;
}
    - (void)test{
        //[AFHTTPSessionManager manager]
    }


- (void)printDocPath{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString*docPath = NSHomeDirectory();
        NSLog(@"homepath :%@",docPath);
    });
}

- (void)initCofing{
    NSString *root = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    root = [root stringByAppendingPathComponent:@"ARSource/"];
    _fileRootPath =  root;

    if (![[NSFileManager defaultManager] fileExistsAtPath:root]){
        [[NSFileManager defaultManager]  createDirectoryAtPath:root withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
}

- (void)zipFile{
    [self printDocPath];
    [self initCofing];
    
    double time1 = CFAbsoluteTimeGetCurrent();
    NSString*file = [_fileRootPath stringByAppendingString:@"/1.zip"];
    
    if ([SSZipArchive unzipFileAtPath:file toDestination:_fileRootPath]){
        
    }else{
        
    }
    double time2 = CFAbsoluteTimeGetCurrent() - time1;
    NSLog(@"%f", time2);
}

+ (void)weexInit{
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];

    [WXSDKEngine initSDKEnvironment];
    
    //to do
    [WXSDKEngine registerHandler:[ImageHandler new] withProtocol:@protocol(WXImgLoaderProtocol)];
    [WXSDKEngine registerHandler:[navhandler new] withProtocol:@protocol(WXNavigationProtocol)];
    [WXSDKEngine registerModule:@"event2" withClass:NSClassFromString(@"navNative")];
    [WXLog setLogLevel: WXLogLevelError];
}
@end

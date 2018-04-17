//
//  ObjcBridge.h
//  testFrame
//
//  Created by xianhuanlin on 2017/8/30.
//  Copyright © 2017年 xianhuanlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wxViewController.h"

//#import "AFNetworking.h"

@interface ObjcBridge : UIView
- (void)zipFile;


- (void)loadImage:(UIImageView*)view url:(NSString*)url;

+ (void)weexInit;
@end

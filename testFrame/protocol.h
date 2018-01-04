//
//  protocol.h
//  testFrame
//
//  Created by xianhuanlin on 2018/1/4.
//  Copyright © 2018年 xianhuanlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import <WeexSDK/WXModuleProtocol.h>

@interface navNative :  NSObject <WXModuleProtocol>

- (NSString*)getversion;

@end

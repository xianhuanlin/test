//
//  protocol.m
//  testFrame
//
//  Created by xianhuanlin on 2018/1/4.
//  Copyright © 2018年 xianhuanlin. All rights reserved.
//

#import "protocol.h"


@implementation navNative

@synthesize weexInstance;
WX_EXPORT_METHOD_SYNC(@selector(getversion))
WX_EXPORT_METHOD(@selector(openProtocol:))
#pragma mark Weex Application Interface

//- (void)open:(NSDictionary *)param success:(WXModuleCallback)success failure:(WXModuleCallback)failure
//{
//    id<WXNavigationProtocol> navigator = [self navigator];
//    UIViewController *container = self.weexInstance.viewController;
//    if (navigator && [navigator respondsToSelector:@selector(open:success:failure:withContainer:)]) {
//        [navigator open:param success:success failure:failure withContainer:container];
//    }
//}

- (NSString*)getversion{
    return @"hello world!";
}
- (void)openProtocol:(NSString*)url{
    
}
@end

//
//  wxViewController.m
//  testFrame
//
//  Created by xianhuanlin on 2017/12/26.
//  Copyright © 2017年 xianhuanlin. All rights reserved.
//

#import "wxViewController.h"
#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXSDKInstance.h>
#import <WeexSDK/WXSDKEngine.h>
#import <WeexSDK/WXUtility.h>
#import <WeexSDK/WXDebugTool.h>
#import <WeexSDK/WXSDKManager.h>
#import "ObjcBridge.h"

@interface wxViewController ()

@end

@implementation wxViewController{
    WXSDKInstance*_instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ObjcBridge weexInit];
    });
    self.view.backgroundColor = [UIColor whiteColor];
    _url = @"http://10.66.48.126:12580/examples/build/vue/index.js";
    [self render];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)render{
    
    CGFloat width = self.view.frame.size.width;
    //[_instance destroyInstance];
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    CGRect rect = CGRectMake(0, 64 ,self.view.bounds.size.width, self.view.bounds.size.height/2);
    _instance.frame = self.view.frame;

    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
//            [weakSelf.weexView removeFromSuperview];
//            weakSelf.weexView = view;
        [self.view addSubview:view];
        view.backgroundColor = [UIColor grayColor];
        int a = 0;
        //NSLog(view);
        //UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf.weexView);
    };
    _instance.onFailed = ^(NSError *error) {
        if (error){
            NSLog(@"%@", error);
        }

    };
    
    _instance.renderFinish = ^(UIView *view) {
        WXLogDebug(@"%@", @"Render Finish...");
        //[weakSelf updateInstanceState:WeexInstanceAppear];
    };
    
    _instance.updateFinish = ^(UIView *view) {
        WXLogDebug(@"%@", @"Update Finish...");
    };
    if (!self.url) {
        WXLogError(@"error: render url is nil");
        return;
    }

    
//    NSURL*url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test.we" ofType:@""] isDirectory:NO];
//    [_instance renderWithURL:url2];//[NSURL URLWithString:url2]];
    
    [_instance renderWithURL:[NSURL URLWithString:_url]];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

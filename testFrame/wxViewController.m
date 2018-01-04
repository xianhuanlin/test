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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onleftBarButtonItemClick)];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ObjcBridge weexInit];
    });
    self.view.backgroundColor = [UIColor whiteColor];
    //_url = @"http://10.66.48.126:12580/examples/build/vue/index.js";
    
    
    [self render];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewload" params:nil domChanges:nil];
    });
}

- (void)onleftBarButtonItemClick{
    //[self dismissViewControllerAnimated:YES  completion:nil];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)render{
    CGFloat width = self.view.frame.size.width;
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    CGFloat top = 0;
    if (self.navigationController){
        top = 64;
    }
        
    CGRect rect = CGRectMake(0, top ,self.view.bounds.size.width, self.view.bounds.size.height - top);
    _instance.frame = rect;

    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
//            [weakSelf.weexView removeFromSuperview];
//            weakSelf.weexView = view;
        [self.view addSubview:view];
        view.backgroundColor = [UIColor grayColor];
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

    NSString*localFile = [[NSBundle mainBundle]pathForResource:@"test1.js" ofType:@""];
    NSURL*url = [NSURL fileURLWithPath:localFile];
    
   // if (url == nil)
    {
        url = [NSURL URLWithString:_url];
    }
    [_instance renderWithURL:url];

}


- (void)_updateInstanceState:(WXState)state
{
    if (_instance && _instance.state != state) {
        _instance.state = state;
        
        if (state == WeexInstanceAppear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewappear" params:nil domChanges:nil];
        } else if (state == WeexInstanceDisappear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewdisappear" params:nil domChanges:nil];
        }
    }
}

- (void)_appStateDidChange:(NSNotification *)notify
{
    if ([notify.name isEqualToString:@"UIApplicationDidBecomeActiveNotification"]) {
        [self _updateInstanceState:WeexInstanceForeground];
    } else if([notify.name isEqualToString:@"UIApplicationDidEnterBackgroundNotification"]) {
        [self _updateInstanceState:WeexInstanceBackground]; ;
    }
}

- (void)_addObservers
{
    for (NSString *name in @[UIApplicationDidBecomeActiveNotification,
                             UIApplicationDidEnterBackgroundNotification]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_appStateDidChange:)
                                                     name:name
                                                   object:nil];
    }
}

- (void)_removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self _updateInstanceState:WeexInstanceAppear];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self _updateInstanceState:WeexInstanceDisappear];
}



- (void)dealloc
{
    [_instance destroyInstance];
    [self _removeObservers];
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

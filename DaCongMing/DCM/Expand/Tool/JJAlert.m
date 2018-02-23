//
//  JJAlert.m
//  UnicornTV
//
//  Created by JerodJi on 2017/11/23.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import "JJAlert.h"

@implementation JJAlert

+ (void)showAlert:(NSString*)message
{
    [self showAlert:message withActionTitle:@"确定" action:nil];
}

+ (void)showAlert:(NSString *)message withActionTitle:(NSString*)title action:(ACTION)_action
{
    UIViewController* currentVC = [[self shareIns] getCurrentVC];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* sureAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        if (_action) {
            _action();
        }
    }];
    
    [alert addAction:sureAction];
    [currentVC presentViewController:alert animated:YES completion:nil];
}


#pragma mark -

+ (void)showAlert:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure
{
    UIViewController* currentVC = [[self shareIns] getCurrentVC];
    [self showAlertWithVC:currentVC title:nil message:message cancleAction:_cancle sureAction:_sure];
}

+ (void)showAlertTitle:(NSString*)title msg:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure
{
    UIViewController* currentVC = [[self shareIns] getCurrentVC];
    [self showAlertWithVC:currentVC title:title message:message cancleAction:_cancle sureAction:_sure];
}

+ (void)showAlertWithVC:(UIViewController*)vc title:(NSString*)title message:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
       // NSLog(@"cancleAction = %@", action);
        if (_cancle) {
            _cancle();
        }
    }];
    
    UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
        //NSLog(@"sureAction = %@", action);
        if (_sure) {
            _sure();
        }
        
    }];
    
    [alert addAction:cancleAction];
    [alert addAction:sureAction];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark -

+ (instancetype)shareIns {
    static JJAlert* ins ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[[self class] alloc] init];
    });
    return ins;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self seekCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)seekCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    // 视图是被presented出来的
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    // 根视图为UITabBarController
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self seekCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }
    // 根视图为UINavigationController
    else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self seekCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }
    // 根视图为非导航类
    else {
        currentVC = rootVC;
    }
    return currentVC;
}

@end

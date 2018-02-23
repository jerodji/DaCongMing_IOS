//
//  JJAlert.m
//  UnicornTV
//
//  Created by JerodJi on 2017/11/23.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import "JJAlert.h"

@implementation JJAlert

+ (void)showAlertWithVC:(UIViewController*)vc message:(NSString*)message cancleAction:(void(^)())_cancle sureAction:(void(^)())_sure
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
       // NSLog(@"cancleAction = %@", action);
        _cancle();
    }];
    
    UIAlertAction* sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
        //NSLog(@"sureAction = %@", action);
        _sure();
    }];
    
    [alert addAction:cancleAction];
    [alert addAction:sureAction];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end

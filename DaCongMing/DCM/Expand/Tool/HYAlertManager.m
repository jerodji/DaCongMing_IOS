//
//  HYAlertManager.m
//  DaCongMing
//
//  Created by Jack on 2017/12/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAlertManager.h"

@implementation HYAlertManager

+ (void)alertControllerAboveIn:(UIViewController *)viewController withMessage:(NSString *)message actionTitle:(NSString *)actionTitle actionEvent:(actionBlock)actionEvent{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (actionEvent) {
            actionEvent();
        }
    }];
    [alertVC addAction:action];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)alertControllerAboveIn:(UIViewController *)viewController withMessage:(NSString *)message leftTitle:(NSString *)leftTitle leftActionEvent:(leftActionBlock)leftActionEvent rightTitle:(NSString *)rightTitle rightActionEvent:(rightActionBlock)rightActionEvent{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (leftActionEvent) {
            leftActionEvent();
        }
    }];
    [alertVC addAction:leftAction];
    
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (rightActionEvent) {
            rightActionEvent();
        }
    }];
    [alertVC addAction:rightAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)actionSheetAboveIn:(UIViewController *)viewController withTitle:(NSString *)title Message:(NSString *)message actionTitle:(NSString *)actionTitle actionEvent:(actionBlock)actionEvent cancelTitle:(NSString *)cancelTitle{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (actionEvent) {
            actionEvent();
        }
    }];
    [alertVC addAction:action];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

@end


//
//  HYAlertTool.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^actionBlock)();

typedef void(^leftActionBlock)();

typedef void(^rightActionBlock)();

@interface HYAlertTool : NSObject

/**
 *  确定提示框(只有一个按钮)
 */
+ (void)alertControllerAboveIn:(UIViewController *)viewController
                   withMessage:(NSString *)message
                   actionTitle:(NSString *)actionTitle
                   actionEvent:(actionBlock)actionEvent;

/**
 *  有两个按钮的提示框
 */
+ (void)alertControllerAboveIn:(UIViewController *)viewController
                   withMessage:(NSString *)message
                     leftTitle:(NSString *)leftTitle
               leftActionEvent:(leftActionBlock)leftActionEvent
                    rightTitle:(NSString *)rightTitle
              rightActionEvent:(rightActionBlock)rightActionEvent;

/**
 *  底部的actionSheet
 */
+ (void)actionSheetAboveIn:(UIViewController *)viewController
                 withTitle:(NSString *)title
                   Message:(NSString *)message
               actionTitle:(NSString *)actionTitle
               actionEvent:(actionBlock)actionEvent
               cancelTitle:(NSString *)cancelTitle;

@end

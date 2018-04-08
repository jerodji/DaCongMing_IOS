//
//  JJAlert.h
//  UnicornTV
//
//  Created by JerodJi on 2017/11/23.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SURE)(void);
typedef void(^CANCLE)(void);
typedef void(^ACTION)(void);

@interface JJAlert : NSObject

+ (void)showAlert:(NSString*)message;
+ (void)showAlert:(NSString *)message withActionTitle:(NSString*)title action:(ACTION)_action;

+ (void)showAlert:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure;
+ (void)showAlertTitle:(NSString*)title msg:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure;
+ (void)showAlertWithVC:(UIViewController*)vc title:(NSString*)title message:(NSString*)message cancleAction:(CANCLE)_cancle sureAction:(SURE)_sure;

@end

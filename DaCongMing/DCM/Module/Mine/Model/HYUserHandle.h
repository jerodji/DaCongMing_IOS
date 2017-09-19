//
//  HYUserHandle.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYUserHandle : HYBaseModel

/*!
 手机号登录
 */
+ (void)userLoginWithPhone:(NSString *)phone password:(NSString *)password complectionBlock:(void(^)(BOOL isLoginSuccess))complection;

/*!
 @method
 @brief 跳转到登录VC
 @param fromVC  当前的VC
 */
+ (void)jumpToLoginViewControllerFromVC:(UIViewController *)fromVC;

@end

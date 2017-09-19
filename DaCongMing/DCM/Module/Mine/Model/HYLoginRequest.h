//
//  HYLoginRequest.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYLoginRequest : HYBaseModel

/*!
 手机号登录
 */
+ (void)userLoginWithPhone:(NSString *)phone password:(NSString *)password complectionBlock:(void(^)(BOOL isLoginSuccess))complection;

@end

//
//  HYSetPasswordViewController.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYSetPasswordViewController : HYBaseViewController

/** phone */
@property (nonatomic,copy) NSString *phone;
/** 验证码 （设置密码页面跳转） */
@property (nonatomic,copy) NSString *authCode;

@end

//
//  HYAuthPhoneView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/17.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^authSuccessBlock)();

@interface HYAuthPhoneView : UIView

/** 验证手机号 */
@property (nonatomic,strong) authSuccessBlock authPhoneSuccess;

@end

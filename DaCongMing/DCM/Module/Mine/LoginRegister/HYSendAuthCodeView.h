//
//  HYSendAuthCodeView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AuthCodeSuccess)(NSString *authCode);

@interface HYSendAuthCodeView : UIView

/** 验证码验证成功 */
@property (nonatomic,copy) AuthCodeSuccess authSuccessBlock;

@end

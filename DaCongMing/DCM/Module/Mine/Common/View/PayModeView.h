//
//  PayModeView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/30.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum {
//    PayModeAliPay = 0,
//    PayModeWeChat
//} PayMode;

typedef NS_ENUM(NSInteger,PayMode) {
    PayModeAliPay = 0,
    PayModeWeChat = 1,
    PayModeUniPay = 2
};

typedef void (^ACTIONBK)(PayMode mode);

@interface PayModeView : UIView
@property (nonatomic,readonly) PayMode paymode;
@property (nonatomic,copy) ACTIONBK actionCB;
@end



@interface BuyButton : UIButton

@end

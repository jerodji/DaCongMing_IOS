//
//  HYPayBottomView.h
//  DaCongMing
//
//  Created by Jack on 2017/12/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayBlock)();

@interface HYPayBottomView : UIView

/** 支付按钮 */
@property (nonatomic,copy) PayBlock payBlock;

@end

//
//  HYNoDiscountCouponView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^strollActionBlock)();

@interface HYNoDiscountCouponView : UIView

/** strollActin */
@property (nonatomic,copy) strollActionBlock strollActin;

@end

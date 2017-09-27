//
//  HYRequestOrderHandle.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYRequestOrderHandle : HYBaseModel

/**
 *  请求订单
 */
+ (void)requestOrderDataWithState:(NSInteger)order_state pageNo:(NSInteger )pageNo andPage:(NSInteger )pageSize complectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  请求优惠券
 */
+ (void)requestDiscountCouponComplectionBlock:(void(^)(NSArray *datalist))complection noDataBlock:(void(^)())noDiscountCoupon;

@end

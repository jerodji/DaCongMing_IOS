//
//  HYMyDisCouponModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYMyDisCouponModel : HYBaseModel

/** guid */
@property (nonatomic,copy) NSString *guid;
/** coupon_id */
@property (nonatomic,copy) NSString *coupon_id;
/** user_id */
@property (nonatomic,copy) NSString *user_id;
/** image_url */
@property (nonatomic,copy) NSString *image_url;
/** isuseful */
@property (nonatomic,copy) NSString *isuseful;
/** close_time */
@property (nonatomic,copy) NSString *close_time;
/** amount */
@property (nonatomic,copy) NSString *amount;
/** condition_price */
@property (nonatomic,copy) NSString *condition_price;

@end

/**
 "guid": null,
 "coupon_id": null,
 "user_id": null,
 "image_url": "http://",
 "isuseful": null,
 "create_time": null,
 "close_time": "2020-06-17 11:52:20.0",
 "amount": 0,
 "condition_price": 0
 */

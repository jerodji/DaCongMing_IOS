//
//  HYMyOrderModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYMyOrderModel : HYBaseModel

/** seller_id */
@property (nonatomic,copy) NSString *seller_id;
/** seller_name */
@property (nonatomic,copy) NSString *seller_name;
/** 订单号 */
@property (nonatomic,copy) NSString *sorder_id;
/** summary_qty */
@property (nonatomic,copy) NSString *summary_qty;
/** summary_price */
@property (nonatomic,copy) NSString *summary_price;
/** province_name */
@property (nonatomic,copy) NSString *province_name;
/** city_name */
@property (nonatomic,copy) NSString *city_name;
/** area_name */
@property (nonatomic,copy) NSString *area_name;
/** address */
@property (nonatomic,copy) NSString *address;
/** receiver */
@property (nonatomic,copy) NSString *receiver;
/** phoneNum */
@property (nonatomic,copy) NSString *phoneNum;
/** address */
@property (nonatomic,copy) NSString *create_time;
/** close_time */
@property (nonatomic,copy) NSString *close_time;
/** order_stat */
@property (nonatomic,copy) NSString *order_stat;
/** ispassentry */
@property (nonatomic,copy) NSString *ispassentry;
/** deliverytime */
@property (nonatomic,copy) NSString *deliverytime;
/** orderDtls */
@property (nonatomic, copy) NSArray *orderDtls;

@end

/**
 "seller_id": "001",
 "seller_name": "laohailin",
 "sorder_id": "010201709261000001629508533",
 "summary_qty": 1,
 "summary_price": 0.02,
 "province_name": "河北省",
 "city_name": "石家庄市",
 "area_name": "长安区",
 "address": "都不买看",
 "receiver": "范冰冰",
 "phoneNum": "12345685231",
 "orderDtls": null,
 "user_id": "o-13MvzD5U5LVc",
 "order_id": null,
 "note": null,
 "create_time": "2017-09-26 14:56:20.0",
 "close_time": "2017-09-26 15:11:20.0",
 "order_stat": "1",
 "ispassentry": "0",
 "receipt": null,
 "deliverytime": null
 */

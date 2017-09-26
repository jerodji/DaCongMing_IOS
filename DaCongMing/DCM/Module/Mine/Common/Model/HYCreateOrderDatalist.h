//
//  HYCreateOrderDatalist.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYCreateOrderDatalist : HYBaseModel

/** seller_id */
@property (nonatomic,copy) NSString *seller_id;
/** seller_name */
@property (nonatomic,copy) NSString *seller_name;
/** 订单号 */
@property (nonatomic,copy) NSString *sorder_id;
/** summary_qty */
@property (nonatomic,copy) NSString *summary_qty;
/** user_id */
@property (nonatomic,copy) NSString *user_id;

@end

/**
 *                  "seller_id": "001",
 "seller_name": "laohailin",
 "sorder_id": "010201709251000002028516354",
 "summary_qty": 3,
 "summary_price": 0.03,
 "province_name": "河北省",
 "city_name": "石家庄市",
 "area_name": "长安区",
 "address": "都不买看",
 "receiver": "范冰冰",
 "phoneNum": "12345685231",
 "orderDtls": [
 {
 "guid": "201709251000000775025908",
 "sorder_id": "010201709251000002028516354",
 "item_id": "item_ba0a36d786344c1b9789479c0a5bca49",
 "item_name": "金线莲",
 "unit": "200g",
 "qty": 3,
 "price": 0.03,
 "floor_price": 0,
 "item_title_image": "http://116.62.118.249:80/item_image/image_d18d92dd143140ca9a67e1dc43776f45.jpg",
 "seller_id": null,
 "user_id": null,
 "refingQty": 0,
 "isRefQty": 0
 }
 ],
 "user_id": "o-13MvzD5U5LVc",
 "order_id": null,
 "note": null,
 "create_time": "2017-09-25 16:08:26.0",
 "close_time": "2017-09-25 16:23:26.0",
 "order_stat": "1",
 "ispassentry": "0",
 "receipt": null,
 "deliverytime": null
 */

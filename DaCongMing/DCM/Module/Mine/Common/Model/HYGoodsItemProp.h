//
//  HYGoodsItemProp.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

/**
 *  "prop_id": "prop_e80eacbd0d4146a197f5e5fd1d05d2c0",
 "qty": 1000,
 "unit": "300g",
 "price": 0.02,
 "floor_price": 0,
 "item_id": "item_2acb6c17b13d405280e8d94fb273426c"
 */

@interface HYGoodsItemProp : HYBaseModel

/** 规格编号 */
@property (nonatomic, copy) NSString *prop_id;
/** 库存 */
@property (nonatomic, copy) NSString *qty;
/** 规格 */
@property (nonatomic, copy) NSString *unit;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 底价 */
@property (nonatomic, copy) NSString *floor_price;
/** 商品编号 */
@property (nonatomic, copy) NSString *item_id;

@end

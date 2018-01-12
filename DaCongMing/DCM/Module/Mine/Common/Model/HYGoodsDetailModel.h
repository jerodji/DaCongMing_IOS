//
//  HYGoodsDetailModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

/**
 *  "item_id": "item_2acb6c17b13d405280e8d94fb273426c",
 "item_name": "诺丽果",
 "item_type": "002",
 "item_min_price": null,
 "item_note": "老挝纯天然野生产品",
 "item_of_seller": "001",
 "item_title_image": "http://116.62.118.249:80/item_image/image_9fd0b4a2115f402280c01651f9e8db85.jpg",
 "isFavorite": "0",
 "salesVolume": 0,
 "provincePrice": null
 */

@interface HYGoodsDetailModel : HYBaseModel

@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *item_name;
@property (nonatomic, copy) NSString *item_type;
/** 商品规格 */
@property (nonatomic, copy) NSArray *item_prop;
@property (nonatomic, copy) NSString *item_note;
@property (nonatomic, copy) NSString *item_of_seller;
/** 封面图 */
@property (nonatomic, copy) NSString *item_title_image;
/** 商品图片 */
@property (nonatomic, strong) NSArray *item_images;
/** 销量 */
@property (nonatomic, strong) NSNumber *salesVolume;
/** 收藏  1 收藏 0 未收藏 */
@property (nonatomic, copy) NSString *isFavorite;
/** 商品总库存 */
@property (nonatomic, copy) NSString *summary_qty;
@property (nonatomic, strong) id item_min_price;

@end

//
//  HYBrands.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

/** -------------------商家推荐（也是banner）------------------------ */
@interface HYBrands : HYBaseModel

/**
 "guid": "8106d1fa-7c32-11e7-9ae8-80a589568544",
 "image_url": "http://116.62.118.249:80/menu_image/brands/bod_21.png",
 "seller_id": "001",
 "itemList": null
 */

/** guid */
@property (nonatomic,copy) NSString *guid;
/** image_url */
@property (nonatomic,copy) NSString *image_url;
/** seller_id */
@property (nonatomic,copy) NSString *seller_id;
/** image_url */
@property (nonatomic,copy) NSString *itemList;

@end

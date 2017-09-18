//
//  HYItemListModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//


/**
 "guid": "a2c84243-7c30-11e7-9ae8-80a589568544",
 "image_url": "http://116.62.118.249:80/menu_image/goodhealth/bbc_06.png",
 "note": "养生",
 "type_id": "001",
 "itemList": [
 {
 "item_id": "item_d386811840e747ec87420496c3f34619",
 "item_name": "蝶豆花",
 "item_type": null,
 "item_min_price": "0.06",
 "item_prop": null,
 "item_note": null,
 "item_of_seller": null,
 "item_title_image": "http://116.62.118.249:80/item_image/image_8d93b45b81fc4e95a599bd854a39896c.jpg",
 "item_images": null,
 "isFavorite": null,
 "salesVolume": 0,
 "provincePrice": null
 },
 */

#import "HYBaseModel.h"

@interface HYItemListModel : HYBaseModel

/** item_id */
@property (nonatomic, copy) NSString *item_id;
/** item_name */
@property (nonatomic, copy) NSString *item_name;
/** item_type */
@property (nonatomic, copy) NSString *item_type;
/** item_min_price */
@property (nonatomic, strong) NSNumber *item_min_price;
/** item_prop */
@property (nonatomic, copy) NSString *item_prop;
/** item_id */
@property (nonatomic, copy) NSString *item_of_seller;
/** item_title_image */
@property (nonatomic, copy) NSString *item_title_image;
/** item_images */
@property (nonatomic, copy) NSString *item_images;
/** isFavorite */
@property (nonatomic, copy) NSString *isFavorite;
/** salesVolume */
@property (nonatomic, copy) NSString *salesVolume;
/** provincePrice */
@property (nonatomic, copy) NSString *provincePrice;

@end

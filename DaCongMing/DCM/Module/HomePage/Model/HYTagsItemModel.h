//
//  HYTagsItemModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYTagsItemModel : HYBaseModel

/**
 "id": "001",
 "name": "补肾",
 "image_url": "http://116.62.118.249:80/menu_image/brands/bod_24.png"
 */

/** id */
@property (nonatomic, copy) NSString *guid;
/** name */
@property (nonatomic, copy) NSString *item_type;
/** img */
@property (nonatomic, copy) NSString *image_url;

@end

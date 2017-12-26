//
//  HYTypeRecommendItemModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYTypeRecommendItemModel : HYBaseModel

/**  
 "guid": "0cb78d40-7c34-11e7-9ae8-80a589568544",
 "type_id": "100001",
 "type_name": "普洱茶",
 "image_url": "http://116.62.118.249/type_image/second_type/bod_33.png",
 "parent_id": "001"
 */

/** guid */
@property (nonatomic, copy) NSString *guid;
/** type_id */
@property (nonatomic, copy) NSString *type_id;
/** type_name */
@property (nonatomic, copy) NSString *type_name;
/** image_url */
@property (nonatomic, copy) NSString *image_url;
/** parent_id */
@property (nonatomic, copy) NSString *parent_id;
/** item_id */
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *keyWord;

@end

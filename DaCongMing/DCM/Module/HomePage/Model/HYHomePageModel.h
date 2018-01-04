//
//  HYHomePageModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYReCommendTday.h"
#import "HYGoodHealthModel.h"


/** -------------------banner下面的图------------------------ */
@interface HYDisCount : NSObject  <NSCoding>

/**
 "guid": "6042eb44-7c2f-11e7-9ae8-80a589568544",
 "image_url": "http://116.62.118.249:80/menu_image/discount/bbc_03.png",
 "note": "折扣"
 */

/** guid */
@property (nonatomic,copy) NSString *guid;
/** image_url */
@property (nonatomic,copy) NSString *image_url;
/** note */
@property (nonatomic,copy) NSString *note;
/** CellHeight */
@property (nonatomic,assign) CGFloat cellHeight;

@end

/** -------------------banner下面的图------------------------ */
@interface HYTypeReCommend : NSObject <NSCoding>

/**
 "guid": "41cf3467-7c32-11e7-9ae8-80a589568544",
 "image_url": "http://116.62.118.249:80/menu_image/menu_TypeReCommend/bod_31.png",
 "type_id": "001",
 "itemSecondaryTypeList": [
 {
 "guid": "0cb78d40-7c34-11e7-9ae8-80a589568544",
 "type_id": "100001",
 "type_name": "普洱茶",
 "image_url": "http://116.62.118.249/type_image/second_type/bod_33.png",
 "parent_id": "001"
 },
 {
 "guid": "0cc5088e-7c34-11e7-9ae8-80a589568544",
 "type_id": "100002",
 "type_name": "金边玫瑰",
 "image_url": "http://116.62.118.249/type_image/second_type/bod_35.png",
 "parent_id": "001"
 },
 {
 "guid": "0ccfd2cd-7c34-11e7-9ae8-80a589568544",
 "type_id": "100003",
 "type_name": "晒红",
 "image_url": "http://116.62.118.249/type_image/second_type/bod_37.png",
 "parent_id": "001"
 },
 {
 "guid": "0cd766df-7c34-11e7-9ae8-80a589568544",
 "type_id": "100004",
 "type_name": "石斛",
 "image_url": "http://116.62.118.249/type_image/second_type/bod_39.png",
 "parent_id": "001"
 }
 ]
 */

/** guid */
@property (nonatomic,copy) NSString *guid;
/** image_url */
@property (nonatomic,copy) NSString *image_url;
/** note */
@property (nonatomic,copy) NSString *type_id;
@property (nonatomic,copy) NSString *keyWord;
@property (nonatomic,copy) NSString *seller_id;
/** itemSecondaryTypeList */
@property (nonatomic,strong) NSArray *itemSecondaryTypeList;

@end

@interface HYHomeMenuTitle : NSObject

@property (nonatomic,copy) NSString *sub_title;
@property (nonatomic,copy) NSString *main_title;

@end

@interface HYHomePageModel : NSObject <NSCoding>

/** banner */
@property (nonatomic,copy) NSArray *banners;

/** 今日限时 */
@property (nonatomic,copy) NSArray *reCommendTday;

/** 商家推荐（也是banner） */
@property (nonatomic,copy) NSArray *brands;

/** banner下面的图 */
@property (nonatomic,strong) HYDisCount *disCount;

/** 类型推荐 */
@property (nonatomic,strong) HYTypeReCommend *typeReCommend;

/** 标签 */
@property (nonatomic,copy) NSArray *tags;

/** hotSale */
@property (nonatomic,copy) NSDictionary *hotSale;
/** 文本标题 */
@property (nonatomic,strong) HYHomeMenuTitle *menu_module;
/** 健康养生 */
@property (nonatomic,strong) HYGoodHealthModel *goodHealth;

@end

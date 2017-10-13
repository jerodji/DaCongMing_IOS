//
//  HYMyCollectShopModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMyCollectShopModel : NSObject

/** guid */
@property (nonatomic,copy) NSString *guid;
/** seller_id */
@property (nonatomic,copy) NSString *seller_id;
/** seller_name */
@property (nonatomic,copy) NSString *seller_name;
/** seller_pwd */
@property (nonatomic,copy) NSString *seller_pwd;
/** storeImages */
@property (nonatomic,copy) NSString *storeImages;
/** item_list */
@property (nonatomic,copy) NSArray *item_list;
/** isFavorite */
@property (nonatomic,copy) NSString *isFavorite;

@end

@interface HYMyCollectShopItemList : NSObject

/** guid */
@property (nonatomic,copy) NSString *item_id;
/** item_type */
@property (nonatomic,copy) NSString *item_type;
/** seller_name */
@property (nonatomic,copy) NSString *seller_name;
/** item_min_price */
@property (nonatomic,copy) NSString *item_min_price;
/** item_note */
@property (nonatomic,copy) NSString *item_note;
/** item_title_image */
@property (nonatomic,copy) NSString *item_title_image;
/** item_min_price */
@property (nonatomic,copy) NSString *item_images;
/** item_note */
@property (nonatomic,copy) NSString *isFavorite;
/** item_title_image */
@property (nonatomic,copy) NSString *item_of_seller;

@end


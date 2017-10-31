//
//  HYBrandShopInfoModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBrandShopInfoModel : NSObject

/** guid */
@property (nonatomic,copy) NSString *guid;
/** guid */
@property (nonatomic,copy) NSString *seller_id;
/** guid */
@property (nonatomic,copy) NSString *seller_name;
/** guid */
@property (nonatomic,copy) NSString *seller_pwd;
/** guid */
@property (nonatomic,copy) NSString *item_list;
/** guid */
@property (nonatomic,copy) NSString *isFavorite;
/** guid */
@property (nonatomic,copy) NSArray *storeImages;
/** hotsaleCount */
@property (nonatomic,copy) NSString *hotsaleCount;
/** guid */
@property (nonatomic,copy) NSString *itemCount;
/** itemNewCount */
@property (nonatomic,copy) NSString *itemNewCount;
/** justItem */
@property (nonatomic,copy) NSArray *justItem;

@end

/**
 *  "guid": "sdfsadfas",
 "seller_id": "001",
 "seller_name": "laohailin",
 "seller_pwd": "gogo1212",
 "item_list": null,
 "isFavorite": "0"
 */

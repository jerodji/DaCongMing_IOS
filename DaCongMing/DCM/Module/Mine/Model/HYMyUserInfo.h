//
//  HYMyUserInfo.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMyUserInfo : NSObject

/** id */
@property (nonatomic, copy) NSString *id;
/** name */
@property (nonatomic, copy) NSString *name;
/** age */
@property (nonatomic, copy) NSString *age;
/** sex */
@property (nonatomic, copy) NSString *sex;
/** adress */
@property (nonatomic, copy) NSString *adress;
/** phone */
@property (nonatomic, copy) NSString *phone;
/** note */
@property (nonatomic, copy) NSString *note;
/** head_image_url */
@property (nonatomic, copy) NSString *head_image_url;
/** qr */
@property (nonatomic, copy) NSString *qrpath;
/** user_type */
@property (nonatomic, copy) NSString *user_type;
/** 收藏店铺数量 */
@property (nonatomic, copy) NSString *favStoreNum;
/** 收藏商品数量 */
@property (nonatomic, copy) NSString *favItemNum;
/** 购物车数量 */
@property (nonatomic, copy) NSString *cartItemNum;
/** 最近浏览 */
@property (nonatomic, copy) NSString *browseRecordsNum;

/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  清除所有的数据
 */
- (void)clearData;

@end

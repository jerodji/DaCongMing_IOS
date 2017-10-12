//
//  HYMineNetRequest.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYMineNetRequest : NSObject

/**
 *  获取我的收藏商品
 */
+ (void)getMyCollectGoodsWithPageNo:(NSInteger )PageNo ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  获取我的收藏商品
 */
+ (void)getMyCollectShopWithPageNo:(NSInteger )PageNo ComplectionBlock:(void(^)(NSArray *datalist))complection;


/**
 *  我的分享
 */
+ (void)getMyShareWithComplectionBlock:(void(^)(NSDictionary *shareDict))complection;

@end

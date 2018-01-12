//
//  HYSearchHandle.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYItemListModel.h"

@interface HYSearchHandle : NSObject

/**
 *  搜索产品
 */
+ (void)searchProductsWithText:(NSString *)text pageNo:(NSInteger)pageNo complectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  搜索产品
 */
+ (void)searchProductsInShop:(NSString *)sellerID WithText:(NSString *)text complectionBlock:(void(^)(NSArray *datalist))complection;

@end

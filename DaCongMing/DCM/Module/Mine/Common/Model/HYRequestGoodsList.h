//
//  HYRequestGoodsList.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYGoodsDetailModel.h"

@interface HYRequestGoodsList : HYBaseModel

/**
 *  请求商品列表
 */
+ (void)requestGoodsListItem_type:(NSString *)item_type pageNo:(NSInteger )pageNo andPage:(NSInteger )pageSize order:(NSString *)order hotsale:(NSString *)hotSale complectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  请求商品详情
 */
+ (void)requestProductsDetailWithGoodsID:(NSString *)goodsID andToken:(NSString *)token complectionBlock:(void(^)(HYGoodsDetailModel *model))complection;

@end

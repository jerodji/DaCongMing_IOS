//
//  HYGoodsHandle.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYGoodsDetailModel.h"
#import "HYCreateOrder.h"

@interface HYGoodsHandle : HYBaseModel

/**
 *  请求商品列表
 */
+ (void)requestGoodsListItem_type:(NSString *)item_type pageNo:(NSInteger )pageNo andPage:(NSInteger )pageSize order:(NSString *)order hotsale:(NSString *)hotSale complectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  请求商品详情
 */
+ (void)requestProductsDetailWithGoodsID:(NSString *)goodsID andToken:(NSString *)token complectionBlock:(void(^)(HYGoodsDetailModel *model))complection;

/**
 *  创建订单
 */
+ (void)createOrderWithGuid:(NSString *)guid itemID:(NSString *)itemID count:(NSInteger)count sellerID:(NSString *)sellerID andUnit:(NSString *)unit complectionBlock:(void(^)(HYCreateOrder *order))complection;


@end

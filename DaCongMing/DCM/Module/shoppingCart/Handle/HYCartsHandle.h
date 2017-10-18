//
//  HYCartsHandle.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYCartsModel.h"

@interface HYCartsHandle : NSObject

/*!
 @method
 @brief 查看购物车
 */
+ (void)showMyShoppingCartsWithComplectionBlock:(void(^)(HYCartsModel *cartsModel))complection;


/*!
 @method
 @brief 计算购物车价格
 */
+ (void)calculateCartsAmountWithGuid:(NSString *)guid ComplectionBlock:(void(^)(NSString *amount))complection;

/*!
 @method
 @brief 批量修改购物车
 */
+ (void)bulkEditingCartsAmountWithGuid:(NSString *)editJson ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/*!
 @method
 @brief 购物车结算
 */
+ (void)settleCartsWithGuid:(NSString *)guids ComplectionBlock:(void(^)(HYCreateOrder *order))complection;

@end

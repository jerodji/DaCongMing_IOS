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

@end

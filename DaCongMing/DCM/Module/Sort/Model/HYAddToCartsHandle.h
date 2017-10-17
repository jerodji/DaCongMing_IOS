//
//  HYAddToCartsHandle.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYGoodSpecificationSelectView.h"

@interface HYAddToCartsHandle : NSObject  <HYGoodsSpecificationSelectDelegate>

/**
 *  添加到购物车
 */
- (void)addToCartsWithProductID:(NSString *)productID;

@end

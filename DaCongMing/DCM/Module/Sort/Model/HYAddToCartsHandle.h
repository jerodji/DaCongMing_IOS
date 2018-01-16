//
//  HYAddToCartsHandle.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>
#import "HYGoodSpecificationSelectView.h"

@interface HYAddToCartsHandle : NSObject  <HYGoodsSpecificationSelectDelegate>

/**
 *  添加到购物车
 */
- (void)addToCartsWithProductID:(NSString *)productID;

@end

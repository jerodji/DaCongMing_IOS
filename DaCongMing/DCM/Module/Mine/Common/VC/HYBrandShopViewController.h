//
//  HYBrandShopViewController.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

typedef NS_ENUM(NSUInteger, HYBrandShopTopItem) {
    HYBrandShopTopItemHome = 0,
    HYBrandShopTopItemAll,
    HYBrandShopTopItemHotSale,
    HYBrandShopTopItemNew
};

@interface HYBrandShopViewController : HYBaseViewController

/** 商家ID */
@property (nonatomic,copy) NSString *sellerID;
/** 顶部四个按钮 */
@property (nonatomic,assign) HYBrandShopTopItem topItem;

@end

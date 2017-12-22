//
//  HYGoodsListViewController.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

typedef NS_ENUM(NSUInteger, HYGoodsListType) {
    HYGoodsListTypeDefault = 0,
    HYGoodsListTypeSalesVolumeDesc,
    HYGoodsListTypeSalesVolumeAesc,
    HYGoodsListTypePriceDesc,
    HYGoodsListTypePriceAesc
};

@interface HYGoodsListViewController : HYBaseViewController

/** type */
@property (nonatomic,copy) NSString *type;

@end

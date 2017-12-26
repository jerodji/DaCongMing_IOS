//
//  HYBrandShopHeaderView.h
//  DaCongMing
//
//  Created by Jack on 2017/12/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBrandShopInfoModel.h"

typedef void(^BrandShopTopBtnSelectBlcok)(NSInteger tag);

@interface HYBrandShopHeaderView : UIView

/** 商家信息 */
@property (nonatomic,strong) HYBrandShopStoreInfo *storeInfo;

@property (nonatomic,copy) BrandShopTopBtnSelectBlcok topBtnSelectBlock;

@end

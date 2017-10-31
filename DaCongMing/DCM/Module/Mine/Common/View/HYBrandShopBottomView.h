//
//  HYBrandShopBottomView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYBrandsShopBottomActionDelegate <NSObject>

- (void)brandsBottomBtnTapIndex:(NSInteger)index;

@end

@interface HYBrandShopBottomView : UIView

/** allGoodsBtn */
@property (nonatomic,strong) UIButton *allGoodsBtn;
/** hotSaleBtn */
@property (nonatomic,strong) UIButton *hotSaleBtn;
/** newProductBtn */
@property (nonatomic,strong) UIButton *recentNewBtn;

/** delegate */
@property (nonatomic,weak) id<HYBrandsShopBottomActionDelegate>delegate;

@end

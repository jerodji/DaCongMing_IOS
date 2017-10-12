//
//  HYBrandShopNavView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYBrandsShopTapDelegate <NSObject>

- (void)brandsShopNavBtnTapIndex:(NSInteger)index;

@end

@interface HYBrandShopNavView : UIView

/** delegate */
@property (nonatomic,weak) id<HYBrandsShopTapDelegate> delegate;

@end

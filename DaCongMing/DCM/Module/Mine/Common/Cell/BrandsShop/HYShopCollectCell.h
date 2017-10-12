//
//  HYShopCollectCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBrandShopInfoModel.h"

@protocol HYShopCollectDelegate <NSObject>

- (void)shopCollectClick:(BOOL)isCollect;

@end

@interface HYShopCollectCell : UITableViewCell

/** 店铺信息 */
@property (nonatomic,strong) HYBrandShopInfoModel *infoModel;

/** delegate */
@property (nonatomic,weak) id<HYShopCollectDelegate> delegate;

@end

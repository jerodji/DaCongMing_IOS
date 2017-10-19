//
//  HYCartsItemTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCartsModel.h"

@protocol HYSelectCartItemDelegate <NSObject>

/**
 *  购物车每个项目选择按钮点击
 */
- (void)cartItemSelect:(BOOL)isSelect WithIndexPath:(NSIndexPath *)indexPath;

@end

@interface HYCartsItemTableViewCell : UITableViewCell

/** 商品item */
@property (nonatomic,strong) HYCartItems *items;

/** indexPath */
@property (nonatomic,strong) NSIndexPath *indexPath;

/** delegate */
@property (nonatomic,weak) id<HYSelectCartItemDelegate> delegate;

@end

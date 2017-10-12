//
//  HYCartsItemTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCartsModel.h"

typedef void(^cartItemChangedBlock)(HYCartItems *cartItems,NSIndexPath *changeIndexPath);

@interface HYCartsItemTableViewCell : UITableViewCell

/** 商品item */
@property (nonatomic,strong) HYCartItems *items;

/** indexPath */
@property (nonatomic,strong) NSIndexPath *indexPath;

/** 购物车发生变化 */
@property (nonatomic,copy) cartItemChangedBlock cartItemChanged;

@end

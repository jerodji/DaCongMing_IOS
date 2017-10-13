//
//  HYMyOrderTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMyOrderModel.h"

@protocol HYMyOrderBtnActionDelegate <NSObject>

- (void)myOrderBtnActionWithStr:(NSString *)title WithIndexPath:(NSIndexPath *)indexPath;

@end

@interface HYMyOrderTableViewCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYMyOrderModel *model;

/** ind */
@property (nonatomic,strong) NSIndexPath *indexPath;

/** delegate */
@property (nonatomic,weak) id<HYMyOrderBtnActionDelegate>delegate;

@end

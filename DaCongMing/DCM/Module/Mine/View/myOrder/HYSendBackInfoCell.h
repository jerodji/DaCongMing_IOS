//
//  HYSendBackInfoCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYRefundModel.h"

@protocol HYSumbitLogisticInfoDelegate <NSObject>

- (void)submitLogisticWithCompany:(NSString *)company andNumber:(NSString *)number;

@end

@interface HYSendBackInfoCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYRefundModel *model;

/** delegate */
@property (nonatomic,weak) id<HYSumbitLogisticInfoDelegate> delegate;

@end

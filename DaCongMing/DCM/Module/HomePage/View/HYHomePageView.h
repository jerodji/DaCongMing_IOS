//
//  HYHomePageView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYHomePageModel.h"

@interface HYHomePageView : UITableView <SDCycleScrollViewDelegate>

/** 数据源 */
@property (nonatomic,strong) HYHomePageModel *model;

@end

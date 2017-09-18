//
//  HYHomeBannerCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYHomePageModel.h"

@interface HYHomeBannerCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYHomePageModel *model;

/** bannerArray */
@property (nonatomic,strong) NSMutableArray *bannerArray;

@end

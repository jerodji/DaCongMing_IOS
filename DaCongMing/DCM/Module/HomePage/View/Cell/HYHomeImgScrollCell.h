//
//  HYHomeImgScrollCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGoodHealthModel.h"

@interface HYHomeImgScrollCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYGoodHealthModel *goodHealthModel;

/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;

@end

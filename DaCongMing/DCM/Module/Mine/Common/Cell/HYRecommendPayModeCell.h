//
//  HYRecommendPayModeCell.h
//  DaCongMing
//
//  Created by Jack on 2017/12/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYParterPayModel.h"

@interface HYRecommendPayModeCell : UITableViewCell


@property (nonatomic,strong) NSIndexPath *indexPath;
/** model */
@property (nonatomic,strong) HYParterPayModel *model;
/** 选择按钮 */
@property (nonatomic,strong) UIButton *selectBtn;

- (void)setIConImage:(NSString *)icon andTitle:(NSString *)title;

@end

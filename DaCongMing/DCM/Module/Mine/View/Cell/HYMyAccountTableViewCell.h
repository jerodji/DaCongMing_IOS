//
//  HYMyAccountTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYMyAccountTableViewCell : UITableViewCell

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** headerImgView */
@property (nonatomic,strong) UIImageView *headerImgView;
/** 用户名 */
@property (nonatomic,strong) UILabel *nickNameLabel;

@end

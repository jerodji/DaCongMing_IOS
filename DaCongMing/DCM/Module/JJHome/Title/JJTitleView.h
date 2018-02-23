//
//  JJTitleView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJHomeDefine.h"

typedef void(^MoreNatureBLK)();

@interface JJTitleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (nonatomic,copy) MoreNatureBLK  moreNatureCB;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame itemType:(TableItemStyle)itemType;

@end

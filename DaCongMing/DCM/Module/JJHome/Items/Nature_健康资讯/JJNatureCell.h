//
//  JJNatureCell.h
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJNatureModel.h"

typedef void (^LOOKBTNBLK)();

@interface JJNatureCell : UIView

@property (nonatomic, assign) CGRect rectFrame;
@property (nonatomic, strong) JJNatureModel* model;
@property (copy, nonatomic) LOOKBTNBLK btnCB;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end

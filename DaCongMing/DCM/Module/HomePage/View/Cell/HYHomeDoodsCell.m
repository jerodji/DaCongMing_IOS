//
//  HYHomeDoodsCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeDoodsCell.h"

@interface HYHomeDoodsCell()

/** 猜你喜欢  */
@property (nonatomic,strong) UILabel *guessLikeLabel;

@end

@implementation HYHomeDoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.guessLikeLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_guessLikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.height.equalTo(@40);
    }];
}

#pragma mark - lazyload
- (UILabel *)guessLikeLabel{

    if (!_guessLikeLabel) {
        
        _guessLikeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _guessLikeLabel.font = KFitFont(15);
        _guessLikeLabel.textColor = KAPP_BLACK_COLOR;
        _guessLikeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _guessLikeLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

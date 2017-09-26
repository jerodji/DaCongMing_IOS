//
//  HYPayResultTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYPayResultTableViewCell.h"

@interface HYPayResultTableViewCell()

/** payResult */
@property (nonatomic,strong) UIImageView *resultImgView;

@end

@implementation HYPayResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.resultImgView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_resultImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.equalTo(self);
    }];
}

#pragma mark - setter
- (void)setIsPaySuccess:(BOOL)isPaySuccess{
    
    _isPaySuccess = isPaySuccess;
    
    if (isPaySuccess) {
        _resultImgView.image = [UIImage imageNamed:@"pay_success"];
    }
    else{
        _resultImgView.image = [UIImage imageNamed:@"pay_failed"];
    }
}

#pragma mark - lazyload
- (UIImageView *)resultImgView{
    
    if (!_resultImgView) {
        
        _resultImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pay_success"]];
        _resultImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _resultImgView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

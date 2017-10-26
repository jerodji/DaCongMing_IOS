//
//  HYCommentLookMoreCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCommentLookMoreCell.h"

@interface HYCommentLookMoreCell()

@property (nonatomic,strong) UILabel *lookMoreLabel;
/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;

@end

@implementation HYCommentLookMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.lookMoreLabel];
    [self addSubview:self.arrowImgView];
}

- (void)layoutSubviews{
    
    [_lookMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.left.right.equalTo(self);
    }];
    
    CGFloat width = [_lookMoreLabel.text widthForFont:KFitFont(14)];
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(self.width / 2 + width / 2 + 2);
        make.width.equalTo(@30);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UILabel *)lookMoreLabel{
    
    if (!_lookMoreLabel) {
        
        _lookMoreLabel = [UILabel new];
        _lookMoreLabel.text = @"查看更多";
        _lookMoreLabel.textColor = KAPP_b7b7b7_COLOR;
        _lookMoreLabel.font = KFitFont(14);
        _lookMoreLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _lookMoreLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

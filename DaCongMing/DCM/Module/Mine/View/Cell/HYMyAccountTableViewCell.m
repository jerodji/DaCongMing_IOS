//
//  HYMyAccountTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyAccountTableViewCell.h"

@interface HYMyAccountTableViewCell()

/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYMyAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.headerImgView];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.bottomLine];

}

- (void)layoutSubviews{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@180);
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(20 / 1.77));
        make.centerY.equalTo(self);
        make.height.equalTo(@(20));
    }];
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_arrowImgView.mas_left).offset(-10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_arrowImgView.mas_left).offset(-10 * WIDTH_MULTIPLE);
        make.top.height.equalTo(_titleLabel);
        make.width.equalTo(@180);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}


#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"用户名";
        _titleLabel.textColor = KAPP_272727_COLOR;
    }
    return _titleLabel;
}

- (UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = KFitFont(14);
        _nickNameLabel.textAlignment = NSTextAlignmentRight;
        _nickNameLabel.text = @"愿你出走半生，归来认识少年";
        _nickNameLabel.textColor = KAPP_272727_COLOR;
    }
    return _nickNameLabel;
}

- (UIImageView *)headerImgView{
    
    if (!_headerImgView) {
        
        _headerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImgView.clipsToBounds = YES;
        _headerImgView.layer.cornerRadius = 20 * WIDTH_MULTIPLE;
    }
    return _headerImgView;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

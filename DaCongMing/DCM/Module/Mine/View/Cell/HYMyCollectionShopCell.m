//
//  HYMyCollectionShopCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyCollectionShopCell.h"

@interface HYMyCollectionShopCell()

/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** icon图片 */
@property (nonatomic,strong) UIImageView *shopIconImgView;
/** nameLabel */
@property (nonatomic,strong) UILabel *nameLabel;
/** 自营 */
@property (nonatomic,strong) UILabel *selfSellerLabel;
/** 收藏 */
@property (nonatomic,strong) UIButton *collectBtn;
/** shopImg */
@property (nonatomic,strong) UIImageView *shopImgView;
/** line */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYMyCollectionShopCell

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
    
    [self addSubview:self.bgView];
    [self addSubview:self.shopIconImgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.selfSellerLabel];
    [self addSubview:self.collectBtn];
    [self addSubview:self.shopImgView];
    [self addSubview:self.shopIconImgView];
    [self addSubview:self.bottomLine];
    
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.right.bottom.equalTo(self);
    }];
    
    [_shopIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(_bgView).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(35 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(35 * WIDTH_MULTIPLE);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_shopIconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_shopIconImgView);
        make.height.mas_equalTo(20);
        make.right.equalTo(_collectBtn.mas_left);
    }];
    
    [_selfSellerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_shopIconImgView.mas_bottom);
        make.left.equalTo(_shopIconImgView);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(40);
    }];
    
    [_shopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_shopIconImgView);
        make.right.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(20 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE));
    }];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.width.height.equalTo(_shopImgView);
        make.right.equalTo(_shopImgView.mas_left).offset(-15 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UIImageView *)shopIconImgView{
    
    if (!_shopIconImgView) {
        
        _shopIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _shopIconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _shopIconImgView.clipsToBounds = YES;
        _shopIconImgView.image = [UIImage imageNamed:@"placeholder"];
    }
    
    return _shopIconImgView;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [UILabel new];
        _nameLabel.text = @"海林官方旗舰店";
        _nameLabel.textColor = KAPP_272727_COLOR;
        _nameLabel.font = KFitFont(14);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _nameLabel;
}

- (UILabel *)selfSellerLabel{
    
    if (!_selfSellerLabel) {
        
        _selfSellerLabel = [UILabel new];
        _selfSellerLabel.text = @"自营";
        _selfSellerLabel.textColor = KAPP_WHITE_COLOR;
        _selfSellerLabel.font = KFitFont(10);
        _selfSellerLabel.backgroundColor = KAPP_THEME_COLOR;
        _selfSellerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _selfSellerLabel;
}

- (UIButton *)collectBtn{
    
    if (_collectBtn) {
        
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setImage:[UIImage imageNamed:@"product_collect_hl"] forState:UIControlStateNormal];
    }
    return _collectBtn;
}

- (UIImageView *)shopImgView{
    
    if (!_shopImgView) {
        
        _shopImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _shopImgView.contentMode = UIViewContentModeScaleAspectFill;
        _shopImgView.clipsToBounds = YES;
        _shopImgView.image = [UIImage imageNamed:@"brandShopIcon"];
    }
    
    return _shopImgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

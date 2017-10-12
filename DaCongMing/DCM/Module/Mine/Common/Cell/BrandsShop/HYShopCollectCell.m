//
//  HYShopCollectCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShopCollectCell.h"

@interface HYShopCollectCell()

/** 商品图片 */
@property (nonatomic,strong) UIImageView *itemImgView;
/** itemNameLabel */
@property (nonatomic,strong) UILabel *itemLabel;
/** 自营 */
@property (nonatomic,strong) UILabel *selfSellerLabel;
/** 收藏 */
@property (nonatomic,strong) UIButton *collectBtn;

@end

@implementation HYShopCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        self.backgroundColor = KAPP_WHITE_COLOR;
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.itemImgView];
    [self addSubview:self.itemLabel];
    [self addSubview:self.selfSellerLabel];
    [self addSubview:self.collectBtn];

}

- (void)layoutSubviews{
    
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(40 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);

    }];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(60 * WIDTH_MULTIPLE, 24 * WIDTH_MULTIPLE));
    }];
    
    [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_itemImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_itemImgView);
        make.height.mas_equalTo(25);
        make.right.equalTo(_collectBtn.mas_left);
    }];
    
    [_selfSellerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_itemImgView.mas_bottom);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(40);
    }];
}

#pragma mark - setter
- (void)setInfoModel:(HYBrandShopInfoModel *)infoModel{
    
    _infoModel  = infoModel;
//     [_itemImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"iconPlaceholder"]];
    _itemLabel.text = infoModel.seller_name;
    
    if ([infoModel.isFavorite integerValue] == 0) {
        
        _collectBtn.selected = NO;
    }
    else{
        
        _collectBtn.selected = YES;
    }
}

#pragma mark - action
- (void)collectBtnAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(shopCollectClick:)]) {
        
        [_delegate shopCollectClick:[_infoModel.isFavorite integerValue]];
    }
}

#pragma mark - lazyload
- (UIImageView *)itemImgView{
    
    if (!_itemImgView) {
        
        _itemImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _itemImgView.contentMode = UIViewContentModeScaleAspectFill;
        _itemImgView.clipsToBounds = YES;
        _itemImgView.image = [UIImage imageNamed:@"iconPlaceholder"];
    }
    
    return _itemImgView;
}

- (UILabel *)itemLabel{
    
    if (!_itemLabel) {
        
        _itemLabel = [UILabel new];
        _itemLabel.text = @"海林官方旗舰店";
        _itemLabel.textColor = KAPP_272727_COLOR;
        _itemLabel.font = KFitFont(14);
        _itemLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _itemLabel;
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
    
    if (!_collectBtn) {
        
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
        _collectBtn.backgroundColor = KCOLOR(@"383938");
        [_collectBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        [_collectBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateSelected];
        _collectBtn.titleLabel.font = KFitFont(14);
        _collectBtn.layer.borderWidth = 1;
        _collectBtn.layer.cornerRadius = 4;
        _collectBtn.clipsToBounds = YES;
        [_collectBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

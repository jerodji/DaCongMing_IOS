//
//  HYHomeCollectionViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeCollectionViewCell.h"

@interface HYHomeCollectionViewCell()

/** img */
@property (nonatomic,strong) UIImageView *imgView;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 价格 */
@property (nonatomic,strong) UILabel *priceLabel;

@end

@implementation HYHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderColor = KAPP_SEPERATOR_COLOR.CGColor;
        self.layer.borderWidth = 1;
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(self.width * 1.2);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_imgView.mas_bottom);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
}

- (void)setCommendTodayModel:(HYReCommendTday *)commendTodayModel{

    _commendTodayModel = commendTodayModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:commendTodayModel.image_url] placeholderImage:[UIImage imageNamed:@"productPlaceholder"]];
    
    _titleLabel.text = commendTodayModel.item_name;
    _priceLabel.text = commendTodayModel.price.description;
}

- (void)setItemListModel:(HYItemListModel *)itemListModel{

    _itemListModel = itemListModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:itemListModel.item_title_image] placeholderImage:[UIImage imageNamed:@"productPlaceholder"]];
    
    _titleLabel.text = itemListModel.item_name;
    _priceLabel.text = itemListModel.item_min_price.description;
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    
    return _imgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textColor = KAPP_BLACK_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;

}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [UILabel new];
        _priceLabel.font = KFitFont(12);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
    
}

@end

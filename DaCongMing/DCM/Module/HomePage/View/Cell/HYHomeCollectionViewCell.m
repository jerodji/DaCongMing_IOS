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
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        
    }
    return self;
}

- (void)setCommendTodayModel:(HYReCommendTday *)commendTodayModel{

    _commendTodayModel = commendTodayModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:commendTodayModel.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _titleLabel.text = commendTodayModel.item_name;
    _priceLabel.text = commendTodayModel.price.description;
}

- (void)setItemListModel:(HYItemListModel *)itemListModel{

    _itemListModel = itemListModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:itemListModel.item_title_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _titleLabel.text = itemListModel.item_name;
    _priceLabel.text = itemListModel.item_min_price.description;
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 130)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    
    return _imgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.bottom + 5, self.width, 20)];
        _titleLabel.font = KFont(14);
        _titleLabel.textColor = KAPP_BLACK_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;

}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + 5, self.width, 20)];
        _priceLabel.font = KFont(14);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
    
}

@end

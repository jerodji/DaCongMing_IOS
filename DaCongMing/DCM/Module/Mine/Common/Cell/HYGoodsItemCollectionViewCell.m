//
//  HYGoodsItemCollectionViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodsItemCollectionViewCell.h"
#import "HYAddToCartsHandle.h"

@interface HYGoodsItemCollectionViewCell()

/** img */
@property (nonatomic,strong) UIImageView *imgView;
/** title */
@property (nonatomic,strong) UILabel *titleLabel;
/** intro */
@property (nonatomic,strong) UILabel *introLabel;
/** price */
@property (nonatomic,strong) UILabel *priceLabel;
/** addShoping */
@property (nonatomic,strong) UIButton *addToShopingCartsBtn;

@end

@implementation HYGoodsItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.introLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.addToShopingCartsBtn];
}

- (void)setGoodsModel:(HYGoodsItemModel *)goodsModel{
    
    _goodsModel = goodsModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:goodsModel.item_title_image] placeholderImage:[UIImage imageNamed:@"goodsPlaceholder"]];
    _introLabel.text = goodsModel.publicity;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",goodsModel.item_min_price];
    
    NSString *title = [NSString stringWithFormat:@"%@ %@",goodsModel.origin,goodsModel.item_name];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName : KFitFont(14),NSForegroundColorAttributeName : KAPP_272727_COLOR}];
    [attributeStr addAttributes:@{NSBackgroundColorAttributeName : [UIColor blackColor],NSForegroundColorAttributeName : KAPP_WHITE_COLOR} range:NSMakeRange(0, goodsModel.origin.length)];
    _titleLabel.attributedText = attributeStr;

}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(240 * WIDTH_MULTIPLE);
    }];
    
    CGFloat strHeight = [@"哈哈" heightForFont:KFitFont(14) width:KSCREEN_WIDTH];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_imgView).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_imgView.mas_bottom).offset(7 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(- 10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(strHeight * 2);
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self).offset(-40);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(strHeight);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.introLabel);
        make.top.equalTo(self.introLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_addToShopingCartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-6 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_priceLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(30 * WIDTH_MULTIPLE, 30 * WIDTH_MULTIPLE));
    }];
    
    [self layoutIfNeeded];
    self.goodsModel.cellHeight = self.priceLabel.bottom + 6 * WIDTH_MULTIPLE;
}

#pragma mark - action
- (void)addToCartsAction{
    
    HYAddToCartsHandle *handle = [[HYAddToCartsHandle alloc] init];
    [handle addToCartsWithProductID:self.goodsModel.item_id];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.image = [UIImage imageNamed:@"header_placeholder"];
    }
    return _imgView;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KFitFont(18);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.text = @"￥0.01";
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textColor = KCOLOR(@"272727");
        _titleLabel.text = @"纯天然野猪，野生大象，野生河马，野生哈哈";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)introLabel{
    
    if (!_introLabel) {
        
        _introLabel = [[UILabel alloc] init];
        _introLabel.font = KFitFont(12);
        _introLabel.textColor = KCOLOR(@"888888");
        _introLabel.text = @"纯野生，纯天然无污染";
        _introLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _introLabel;
}

- (UIButton *)addToShopingCartsBtn{
    
    if (!_addToShopingCartsBtn) {
        
        _addToShopingCartsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToShopingCartsBtn setBackgroundImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
        [_addToShopingCartsBtn addTarget:self action:@selector(addToCartsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToShopingCartsBtn;
}

@end

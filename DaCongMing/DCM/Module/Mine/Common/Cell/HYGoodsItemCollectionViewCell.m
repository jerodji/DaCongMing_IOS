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
    [self addSubview:self.introLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.addToShopingCartsBtn];
}

- (void)setGoodsModel:(HYGoodsItemModel *)goodsModel{
    
    _goodsModel = goodsModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:goodsModel.item_title_image] placeholderImage:[UIImage imageNamed:@"goodsPlaceholder"]];
    _introLabel.text = goodsModel.item_note;
    _priceLabel.text = goodsModel.item_min_price;
}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@(220 * WIDTH_MULTIPLE));
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(9);
        make.top.equalTo(self.imgView.mas_bottom).offset(7 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(- 4 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.introLabel);
        make.top.equalTo(self.introLabel.mas_bottom).offset(7);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_addToShopingCartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.introLabel);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(- 14 * WIDTH_MULTIPLE);

    }];
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
        _priceLabel.font = KFitFont(16);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.text = @"￥0.01";
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}

- (UILabel *)introLabel{
    
    if (!_introLabel) {
        
        _introLabel = [[UILabel alloc] init];
        _introLabel.font = KFitFont(13);
        _introLabel.textColor = KCOLOR(@"272727");
        _introLabel.text = @"愿你出走半生，归来仍是少年";
        _introLabel.textAlignment = NSTextAlignmentLeft;
        _introLabel.numberOfLines = 2;
    }
    return _introLabel;
}

- (UIButton *)addToShopingCartsBtn{
    
    if (!_addToShopingCartsBtn) {
        
        _addToShopingCartsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToShopingCartsBtn setBackgroundImage:[UIImage imageNamed:@"addShoppingCarts"] forState:UIControlStateNormal];
        [_addToShopingCartsBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addToShopingCartsBtn.titleLabel.font = KFitFont(15);
        [_addToShopingCartsBtn setTitleColor:KCOLOR(@"272727") forState:UIControlStateNormal];
        [_addToShopingCartsBtn addTarget:self action:@selector(addToCartsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToShopingCartsBtn;
}

@end

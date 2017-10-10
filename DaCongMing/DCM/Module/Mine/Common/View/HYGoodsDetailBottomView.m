//
//  HYGoodsDetailBottomView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodsDetailBottomView.h"

@interface HYGoodsDetailBottomView()

/** shoppingCarts */
@property (nonatomic,strong) HYButton *cartsBtn;
/** brandStoreBtn */
@property (nonatomic,strong) HYButton *brandStoreBtn;
/** collectionBtn */
@property (nonatomic,strong) HYButton *collectionBtn;
/** 加入购物车 */
@property (nonatomic,strong) UIButton *addToCartsBtn;
/** 立即购买 */
@property (nonatomic,strong) UIButton *buyBtn;

@end

@implementation HYGoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.cartsBtn];
    [self addSubview:self.brandStoreBtn];
    [self addSubview:self.collectionBtn];
    [self addSubview:self.addToCartsBtn];
    [self addSubview:self.buyBtn];
}

- (void)layoutSubviews{
    
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(@105);
    }];
    
    [_addToCartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.width.equalTo(_buyBtn);
        make.right.equalTo(_buyBtn.mas_left);
    }];
    
    
    CGFloat itemWidth = (KSCREEN_WIDTH - 210) / 3;
    
    [_cartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(self);
        make.width.equalTo(@(itemWidth));
    }];
    
    [_brandStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(_cartsBtn.mas_right);
        make.width.equalTo(@(itemWidth));
    }];
    
    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(_brandStoreBtn.mas_right);
        make.width.equalTo(@(itemWidth));
    }];
}

#pragma mark - action
- (void)cartsBtnAction{
    
    if (self.shoppingCartsAction) {
        
        self.shoppingCartsAction();
    }
}

- (void)brandShopBtnAction{
    
    if (self.brandShopAction) {
        
        self.brandShopAction();
    }
}

- (void)collectBtnAction{
    
    self.collectAction();
}

- (void)addToCartsBtnAction{
    
    if (self.addToCartsAction) {
        
        self.addToCartsAction();
    }
}

- (void)buyNowBtnAction{
    
    if (self.buyNowAction) {
        
        self.buyNowAction();
    }
}

#pragma mark - lazyload
- (HYButton *)cartsBtn{
    
    if (!_cartsBtn) {
        _cartsBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_cartsBtn setTitle:@"购物车" forState:UIControlStateNormal];
        [_cartsBtn setImage:[UIImage imageNamed:@"product_carts"] forState:UIControlStateNormal];
        [_cartsBtn setTitleColor:KAPP_b7b7b7_COLOR forState:UIControlStateNormal];
        _cartsBtn.titleLabel.font = KFont(11);
        [_cartsBtn addTarget:self action:@selector(cartsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cartsBtn;
}

- (HYButton *)brandStoreBtn{
    
    if (!_brandStoreBtn) {
        
        _brandStoreBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_brandStoreBtn setTitle:@"品牌店铺" forState:UIControlStateNormal];
        [_brandStoreBtn setImage:[UIImage imageNamed:@"product_shop"] forState:UIControlStateNormal];
        [_brandStoreBtn setTitleColor:KAPP_b7b7b7_COLOR forState:UIControlStateNormal];
        _brandStoreBtn.titleLabel.font = KFont(11);
        [_brandStoreBtn addTarget:self action:@selector(brandShopBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _brandStoreBtn;
}

- (HYButton *)collectionBtn{
    
    if (!_collectionBtn) {
        
        _collectionBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectionBtn setImage:[UIImage imageNamed:@"product_collect"] forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:KAPP_b7b7b7_COLOR forState:UIControlStateNormal];
        _collectionBtn.titleLabel.font = KFont(11);
        [_collectionBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

- (UIButton *)addToCartsBtn{
    
    if (!_addToCartsBtn) {
        
        _addToCartsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToCartsBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addToCartsBtn.backgroundColor = KCOLOR(@"606060");
        [_addToCartsBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _addToCartsBtn.titleLabel.font = KFitFont(16);
        [_addToCartsBtn addTarget:self action:@selector(addToCartsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToCartsBtn;
}

- (UIButton *)buyBtn{
    
    if (!_buyBtn) {
        
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyBtn.backgroundColor = KCOLOR(@"53d76f");
        [_buyBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = KFitFont(16);
        [_buyBtn addTarget:self action:@selector(buyNowBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}

@end

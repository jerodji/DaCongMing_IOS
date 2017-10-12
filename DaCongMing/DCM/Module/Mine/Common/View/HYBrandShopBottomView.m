//
//  HYBrandShopBottomView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBrandShopBottomView.h"

@interface HYBrandShopBottomView()

/** line */
@property (nonatomic,strong) UIView *topLine;
/** shopHomeBtn */
@property (nonatomic,strong) HYButton *shopHomeBtn;
/** allGoodsBtn */
@property (nonatomic,strong) UIButton *allGoodsBtn;
/** hotSaleBtn */
@property (nonatomic,strong) UIButton *hotSaleBtn;
/** newProductBtn */
@property (nonatomic,strong) UIButton *recentNewBtn;

@end

@implementation HYBrandShopBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        self.backgroundColor = KAPP_WHITE_COLOR;
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.topLine];
    [self addSubview:self.shopHomeBtn];
    [self addSubview:self.allGoodsBtn];
    [self addSubview:self.hotSaleBtn];
    [self addSubview:self.recentNewBtn];

}

- (void)layoutSubviews{
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    CGFloat itemWidth = self.width / 4;
    
    [_shopHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(itemWidth);
    }];
    
    [_allGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.width.equalTo(_shopHomeBtn);
        make.left.equalTo(_shopHomeBtn.mas_right);
    }];
    
    [_hotSaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.width.equalTo(_shopHomeBtn);
        make.left.equalTo(_allGoodsBtn.mas_right);
    }];
    
    [_recentNewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.width.equalTo(_shopHomeBtn);
        make.left.equalTo(_hotSaleBtn.mas_right);
    }];
}

#pragma mark - action
- (void)buttonAction:(UIButton *)button{
    
    
}

#pragma mark - lazyload
- (UIView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [UIView new];
        _topLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _topLine;
}

- (HYButton *)shopHomeBtn{
    
    if (!_shopHomeBtn) {
        
        _shopHomeBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_shopHomeBtn setImage:[UIImage imageNamed:@"brandShop"] forState:UIControlStateNormal];
        [_shopHomeBtn setTitle:@"店铺首页" forState:UIControlStateNormal];
        [_shopHomeBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
        [_shopHomeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _shopHomeBtn.titleLabel.font = KFitFont(14);
    }
    return _shopHomeBtn;
}

- (UIButton *)allGoodsBtn{
    
    if (!_allGoodsBtn) {
        
        _allGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allGoodsBtn setTitle:@"0\n全部商品" forState:UIControlStateNormal];
        _allGoodsBtn.titleLabel.numberOfLines = 0;
        _allGoodsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_allGoodsBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        [_allGoodsBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _allGoodsBtn.titleLabel.font = KFitFont(14);
    }
    return _allGoodsBtn;
}

- (UIButton *)hotSaleBtn{
    
    if (!_hotSaleBtn) {
        
        _hotSaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotSaleBtn setTitle:@"0\n热销" forState:UIControlStateNormal];
        _hotSaleBtn.titleLabel.numberOfLines = 0;
        _hotSaleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_hotSaleBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        [_hotSaleBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _hotSaleBtn.titleLabel.font = KFitFont(14);
    }
    return _hotSaleBtn;
}

- (UIButton *)recentNewBtn{
    
    if (!_recentNewBtn) {
        
        _recentNewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recentNewBtn setTitle:@"0\n上新" forState:UIControlStateNormal];
        _recentNewBtn.titleLabel.numberOfLines = 0;
        _recentNewBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_recentNewBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        [_recentNewBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _recentNewBtn.titleLabel.font = KFitFont(14);
    }
    return _recentNewBtn;
}

@end

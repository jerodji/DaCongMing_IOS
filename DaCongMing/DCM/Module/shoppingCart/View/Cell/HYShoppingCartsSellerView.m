//
//  HYShoppingCartsSellerView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShoppingCartsSellerView.h"

@interface HYShoppingCartsSellerView()

/** whiteBgView */
@property (nonatomic,strong) UIView *whiteBgView;
/** 商家选择 */
@property (nonatomic,strong) UIButton *sellerCheackAllBtn;
/** 商家icon */
@property (nonatomic,strong) UIImageView *sellerIconImgView;
/** 商家名称 */
@property (nonatomic,strong) UILabel *sellerNameLabel;
/** 商家线 */
@property (nonatomic,strong) UIView *sellerLine;
/** 每个itemModel */
@property (nonatomic,strong) NSMutableArray *itemModelArray;

@end

@implementation HYShoppingCartsSellerView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.sellerCheackAllBtn];
    [self addSubview:self.sellerIconImgView];
    [self addSubview:self.sellerNameLabel];
    [self addSubview:self.sellerLine];
}

- (void)layoutSubviews{
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_sellerCheackAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_sellerIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_sellerCheackAllBtn.mas_right).offset(6 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView).offset(6 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(18 * WIDTH_MULTIPLE);
    }];
    
    [_sellerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_sellerIconImgView.mas_right).offset(6 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView);
        make.width.mas_equalTo(200);
        make.height.equalTo(_sellerCheackAllBtn);
    }];
    
    [_sellerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - setter
- (void)setCartsSeller:(HYCartsSeller *)cartsSeller{
    
    _cartsSeller = cartsSeller;
    _sellerNameLabel.text = cartsSeller.seller_name;
    _sellerCheackAllBtn.selected = cartsSeller.isSelect;
}

#pragma mark - action
- (void)sellerCheckAllBtnAction:(UIButton *)button{
    
    DLog(@"button.select is %d",button.selected);
    button.selected = !button.selected;
    DLog(@"button.select is %d",button.selected);
    
    if (_delegate && [_delegate respondsToSelector:@selector(cartSellerSelect:WithIndexPath:)]) {
        
        [_delegate cartSellerSelect:button.selected WithIndexPath:self.index];
    }
}

#pragma mark - lazyload
- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBgView;
}

- (UIButton *)sellerCheackAllBtn{
    
    if (!_sellerCheackAllBtn) {
        
        _sellerCheackAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sellerCheackAllBtn setImage:[UIImage imageNamed:@"selectIcon"] forState:UIControlStateNormal];
        [_sellerCheackAllBtn setImage:[UIImage imageNamed:@"selectIconSelect"] forState:UIControlStateSelected];
        [_sellerCheackAllBtn addTarget:self action:@selector(sellerCheckAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sellerCheackAllBtn;
}

- (UIImageView *)sellerIconImgView{
    
    if (!_sellerIconImgView) {
        
        _sellerIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _sellerIconImgView.contentMode = UIViewContentModeScaleAspectFit;
        _sellerIconImgView.clipsToBounds = YES;
        _sellerIconImgView.image = [UIImage imageNamed:@"product_shop"];
    }
    
    return _sellerIconImgView;
}

- (UILabel *)sellerNameLabel{
    
    if (!_sellerNameLabel) {
        
        _sellerNameLabel = [[UILabel alloc] init];
        _sellerNameLabel.font = KFitFont(13);
        _sellerNameLabel.textColor = KAPP_272727_COLOR;
        _sellerNameLabel.text = @"海林官方旗舰店";
        _sellerNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sellerNameLabel;
}

- (UIView *)sellerLine{
    
    if (!_sellerLine) {
        
        _sellerLine = [UIView new];
        _sellerLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _sellerLine;
}

- (NSMutableArray *)itemModelArray{
    
    if (!_itemModelArray) {
        _itemModelArray = [NSMutableArray array];
    }
    return _itemModelArray;
}

@end

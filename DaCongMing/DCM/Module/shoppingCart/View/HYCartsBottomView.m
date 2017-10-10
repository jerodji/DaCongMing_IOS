//
//  HYCartsBottomView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCartsBottomView.h"

@interface HYCartsBottomView()

/** line */
@property (nonatomic,strong) UIView *topLine;
/** checkAllBtn */
@property (nonatomic,strong) HYButton *checkAllBtn;
/** 结算 */
@property (nonatomic,strong) UIButton *confirmBtn;
/** Price */
@property (nonatomic,strong) UILabel *priceLabel;
/** 邮费 */
@property (nonatomic,strong) UILabel *postLabel;

@end

@implementation HYCartsBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.topLine];
    [self addSubview:self.checkAllBtn];
    [self addSubview:self.priceLabel];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.postLabel];

}

- (void)layoutSubviews{
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [_checkAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-8 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.bottom.equalTo(self).offset(-8 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(8 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(90 * WIDTH_MULTIPLE);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_confirmBtn.mas_left).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(_confirmBtn);
        make.left.equalTo(_checkAllBtn.mas_right).offset(15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(25 * WIDTH_MULTIPLE);
    }];
    
    [_postLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.left.equalTo(_priceLabel);
        make.bottom.equalTo(_confirmBtn);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - action
- (void)confirmAction{
    
    
}

- (void)checkAllBtnAction:(UIButton *)button{
    
    
}

#pragma mark - lazyload
- (UIView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [UIView new];
        _topLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _topLine;
}

- (HYButton *)checkAllBtn{
    
    if (!_checkAllBtn) {
        
        _checkAllBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_checkAllBtn setImage:[UIImage imageNamed:@"selectIcon"] forState:UIControlStateNormal];
        [_checkAllBtn setImage:[UIImage imageNamed:@"selectIconSelect"] forState:UIControlStateSelected];
        [_checkAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_checkAllBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        [_checkAllBtn addTarget:self action:@selector(checkAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _checkAllBtn.titleLabel.font = KFitFont(14);
    }
    return _checkAllBtn;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [UILabel new];
        _priceLabel.text = @"总计:";
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.font = KFitFont(16);
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UILabel *)postLabel{
    
    if (!_postLabel) {
        
        _postLabel = [UILabel new];
        _postLabel.text = @"不含运费";
        _postLabel.textColor = KAPP_b7b7b7_COLOR;
        _postLabel.font = KFitFont(12);
        _postLabel.textAlignment = NSTextAlignmentRight;
    }
    return _postLabel;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"结算" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        _confirmBtn.layer.cornerRadius = 3 * WIDTH_MULTIPLE;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@end

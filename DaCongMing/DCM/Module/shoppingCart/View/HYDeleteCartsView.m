//
//  HYDeleteCartsView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/17.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDeleteCartsView.h"

@interface HYDeleteCartsView()

/** line */
@property (nonatomic,strong) UIView *topLine;
/** 结算 */
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYDeleteCartsView

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
    [self addSubview:self.confirmBtn];
    
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
    
}

#pragma mark - action
- (void)confirmAction{
    
    if (self.deleteBlock) {
        
        self.deleteBlock();
    }
}

- (void)checkAllBtnAction:(UIButton *)button{
    
    button.selected = !button.selected;
    if (self.deleteCheckAllBlock) {
        
        self.deleteCheckAllBlock(button.selected);
    }
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


- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"删除" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        _confirmBtn.layer.cornerRadius = 3 * WIDTH_MULTIPLE;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@end

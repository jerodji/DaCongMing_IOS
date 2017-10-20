//
//  HYSendAuthCodeView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSendAuthCodeView.h"
#import "HYPasswordView.h"

@interface HYSendAuthCodeView()

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 手机号 */
@property (nonatomic,strong) UILabel *phoneLabel;
/** 获取验证码 */
@property (nonatomic,strong) UIButton *sendAuthBtn;
/** autoCodeView */
@property (nonatomic,strong) HYPasswordView *authCodeView;

@end

@implementation HYSendAuthCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        self.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        self.layer.masksToBounds = YES;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.sendAuthBtn];
    [self addSubview:self.authCodeView];
}

- (void)layoutSubviews{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(40 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(16 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_sendAuthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneLabel.mas_bottom).offset(18 * WIDTH_MULTIPLE);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(100 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_authCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_sendAuthBtn.mas_bottom).offset(40 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - action
- (void)sendAuthBtnAction{

}

#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textColor = KAPP_272727_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"我们将发送验证码到";
    }
    return _titleLabel;
}

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _phoneLabel.font = KFitFont(18);
        _phoneLabel.textColor = KAPP_THEME_COLOR;
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.text = @"123****4567";
    }
    return _phoneLabel;
}

- (UIButton *)sendAuthBtn{
    
    if (!_sendAuthBtn) {
        
        _sendAuthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendAuthBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _sendAuthBtn.backgroundColor = KAPP_THEME_COLOR;
        _sendAuthBtn.layer.cornerRadius = 15;
        _sendAuthBtn.layer.masksToBounds = YES;
        [_sendAuthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendAuthBtn addTarget:self action:@selector(sendAuthBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendAuthBtn;
}

- (HYPasswordView *)authCodeView{
    
    if (!_authCodeView) {
        
        _authCodeView = [[HYPasswordView alloc] init];
    }
    return _authCodeView;
}

@end

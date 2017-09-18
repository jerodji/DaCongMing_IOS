//
//  HYCompleteView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCompleteView.h"

@interface HYCompleteView() <UITextFieldDelegate>

/** skipBtn */
@property (nonatomic,strong) UIButton *skipBtn;
/** completeInfoLabel */
@property (nonatomic,strong) UILabel *completeInfoLabel;
/** phoneTextField */
@property (nonatomic,strong) UITextField *phoneTextField;
/** 验证码 */
@property (nonatomic,strong) UIButton *getAuthCodeBtn;
/** 线 */
@property (nonatomic,strong) UIView *line1;
/** authCodeTextField */
@property (nonatomic,strong) UITextField *authCodeTextField;
/** 线 */
@property (nonatomic,strong) UIView *line2;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;
/** 提示 */
@property (nonatomic,strong) UILabel *hintLabel;

@end

@implementation HYCompleteView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{

    [self addSubview:self.skipBtn];
    [self addSubview:self.completeInfoLabel];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.getAuthCodeBtn];
    [self addSubview:self.line1];
    [self addSubview:self.authCodeTextField];
    [self addSubview:self.line2];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.hintLabel];
}

- (void)layoutSubviews{

    [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(30 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.width.equalTo(@(45 * WIDTH_MULTIPLE));
        make.height.equalTo(@(19 * WIDTH_MULTIPLE));
    }];
    
    [_completeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(68 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    [_getAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.completeInfoLabel.mas_bottom).offset(68 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.width.equalTo(@(80 * WIDTH_MULTIPLE));
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.completeInfoLabel.mas_bottom).offset(68 * WIDTH_MULTIPLE);
        make.right.equalTo(self.getAuthCodeBtn.mas_left);
        make.height.equalTo(self.getAuthCodeBtn);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.phoneTextField);
        make.right.equalTo(self.getAuthCodeBtn);
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(9);
        make.height.equalTo(@1);
    }];
    
    [_authCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.line1.mas_bottom).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self.getAuthCodeBtn.mas_left);
        make.height.equalTo(self.getAuthCodeBtn);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.phoneTextField);
        make.right.equalTo(self.getAuthCodeBtn);
        make.top.equalTo(self.authCodeTextField.mas_bottom).offset(9);
        make.height.equalTo(@1);
    }];

    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(self.line2.mas_bottom).offset(50 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.confirmBtn.mas_bottom).offset(56);
        make.left.right.equalTo(self.confirmBtn);
        make.height.equalTo(@80);
    }];
}

#pragma mark - action
- (void)phoneNumEditChanged:(UITextField *)sender{
    
    if (sender == self.phoneTextField) {
        
        if (sender.text.length >= 11) {
            sender.text = [sender.text substringToIndex:11];
            _getAuthCodeBtn.backgroundColor = KCOLOR(@"53d76f");
        }
        else{
            _getAuthCodeBtn.backgroundColor = KCOLOR(@"b7b7b7");
        }
    }
    else{
    
        if (sender.text.length >= 6) {
            
            _confirmBtn.backgroundColor = KCOLOR(@"53d76f");
        }
        else{
            _confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        }
    }
}

- (void)confirmAction{

    
}

- (void)skipAction{

}

#pragma mark - lazyload
- (UIButton *)skipBtn{
    
    if (!_skipBtn) {
        
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipBtn setImage:[UIImage imageNamed:@"skip"] forState:UIControlStateNormal];
        [_skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}

- (UILabel *)completeInfoLabel{
    
    if (!_completeInfoLabel) {
        
        _completeInfoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _completeInfoLabel.font = KFitFont(18);
        _completeInfoLabel.textColor = KAPP_WHITE_COLOR;
        _completeInfoLabel.textAlignment = NSTextAlignmentCenter;
        _completeInfoLabel.text = @"完善资料";
    }
    return _completeInfoLabel;
}

- (UITextField *)phoneTextField{

    if (!_phoneTextField) {
        
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneTextField.delegate = self;
        
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机账号" attributes:@{NSForegroundColorAttributeName:KAPP_WHITE_COLOR,NSFontAttributeName : [UIFont systemFontOfSize:18]}];
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextField.font = [UIFont systemFontOfSize:18];
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.textColor = KAPP_WHITE_COLOR;
        [_phoneTextField addTarget:self action:@selector(phoneNumEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (UIButton *)getAuthCodeBtn{
    
    if (!_getAuthCodeBtn) {
        
        _getAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getAuthCodeBtn.layer.cornerRadius = 3;
        _getAuthCodeBtn.backgroundColor = KCOLOR(@"b7b7b7");
        _getAuthCodeBtn.clipsToBounds  = YES;
        [_getAuthCodeBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _getAuthCodeBtn.titleLabel.font = KFont(14);
    }
    return _getAuthCodeBtn;
}

- (UIView *)line1{

    if (!_line1) {
        
        _line1 = [[UIView alloc] initWithFrame:CGRectZero];
        _line1.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _line1;
}

- (UITextField *)authCodeTextField{
    
    if (!_authCodeTextField) {
        
        _authCodeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _authCodeTextField.delegate = self;
        
        _authCodeTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:KAPP_WHITE_COLOR,NSFontAttributeName : [UIFont systemFontOfSize:18]}];
        _authCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
        _authCodeTextField.font = [UIFont systemFontOfSize:18];
        _authCodeTextField.keyboardType = UIKeyboardTypePhonePad;
        _authCodeTextField.textColor = KAPP_WHITE_COLOR;
        [_authCodeTextField addTarget:self action:@selector(phoneNumEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _authCodeTextField;
}

- (UIView *)line2{
    
    if (!_line2) {
        
        _line2 = [[UIView alloc] initWithFrame:CGRectZero];
        _line2.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _line2;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        _confirmBtn.layer.cornerRadius = 3;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.titleLabel.font = KFitFont(18);
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UILabel *)hintLabel{
    
    if (!_hintLabel) {
        
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        NSString *str = @"为确保您的账户安全，建议完善您的账户资料您将获得 (现金红包)";
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 11;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName : KAPP_WHITE_COLOR,NSFontAttributeName : KFitFont(14),NSParagraphStyleAttributeName:paragraphStyle}];
        NSRange redRange = NSMakeRange(str.length - 6, 6);
        [attributeStr addAttributes:@{NSForegroundColorAttributeName : KCOLOR(@"ff4848")} range:redRange];
        _hintLabel.numberOfLines = 0;
        _hintLabel.attributedText = attributeStr;
    }
    return _hintLabel;
}

@end

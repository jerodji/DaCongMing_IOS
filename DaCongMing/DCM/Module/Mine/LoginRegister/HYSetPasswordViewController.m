//
//  HYSetPasswordViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSetPasswordViewController.h"

@interface HYSetPasswordViewController () <UITextFieldDelegate>

/** bg */
@property (nonatomic,strong) UIImageView *bgImgView;

/** close */
@property (nonatomic,strong) UIButton *closeBtn;

/** 提示 */
@property (nonatomic,strong) UILabel *hintLabel;

/** 密码 */
@property (nonatomic,strong) UITextField *passwordTextField;

/** line */
@property (nonatomic,strong) UIView *line;

/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYSetPasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.hintLabel];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.line];
    [self.view addSubview:self.confirmBtn];

}

- (void)viewDidLayoutSubviews{
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(30);
        make.width.height.equalTo(@40);
    }];
    
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(68 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.hintLabel.mas_bottom).offset(68 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.passwordTextField);
        make.height.equalTo(@1);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(9);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.passwordTextField);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
        make.top.equalTo(self.line.mas_bottom).offset(40);
    }];
}

#pragma mark - action
- (void)confirmAction{

    
}

#pragma mark - lazyload
- (UIImageView *)bgImgView{
    
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImgView.image = [UIImage imageNamed:@"loginBg"];
    }
    return _bgImgView;
}

- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

- (UILabel *)hintLabel{
    
    if (!_hintLabel) {
        
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        NSString *str = @"设置账号登录密码\n下次登录可用手机号为账号";
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName : KAPP_WHITE_COLOR,NSFontAttributeName : KFitFont(18)}];
        NSRange redRange = NSMakeRange(str.length - 12, 12);
        [attributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_WHITE_COLOR,NSFontAttributeName : KFitFont(13)} range:redRange];
        _hintLabel.numberOfLines = 0;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.attributedText = attributeStr;
    }
    return _hintLabel;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请设置您的账号登录密码" attributes:@{NSForegroundColorAttributeName:KAPP_WHITE_COLOR,NSFontAttributeName : [UIFont systemFontOfSize:18]}];
        _passwordTextField.delegate = self;
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:18];
        
    }
    return _passwordTextField;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _line;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KCOLOR(@"53d76f");
        _confirmBtn.layer.cornerRadius = 3;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.titleLabel.font = KFitFont(18);
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

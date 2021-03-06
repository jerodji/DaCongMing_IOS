//
//  HYLoginView.m
//  DaCongMing
//
//

#import "HYLoginView.h"

#import "HYUserHandle.h"

@interface HYLoginView() <UITextFieldDelegate>

/** iconImg */
@property (nonatomic,strong) UIImageView *iconImgView;
/** close */
@property (nonatomic,strong) UIButton *closeBtn;

/** 手机输入框 */
@property (nonatomic,strong) UIView *phoneNumberView;
/** phoneIcon */
@property (nonatomic,strong) UIImageView *phoneIcon;
/** phoneTe */
@property (nonatomic,strong) UITextField *phoneTextField;

/** 手机输入框 */
@property (nonatomic,strong) UIView *passwordView;
/** passIcon  */
@property (nonatomic,strong) UIImageView *passwordIconImgView;
/** passwordTextField */
@property (nonatomic,strong) UITextField *passwordTextField;

/** loginBtn */
@property (nonatomic,strong) UIButton *loginBtn;
/** registerBtn */
@property (nonatomic,strong) UIButton *registerBtn;
/** 忘记密码 */
@property (nonatomic,strong) UIButton *forgetPassBtn;
/** wechatLogin */
@property (nonatomic,strong) UIButton *weChatLoginBtn;
/** 快速登录 */
@property (nonatomic,strong) UILabel *loginLabel;

@end

@implementation HYLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubViews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatLoginCallBack:) name:KWeChatLoginNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:KWeChatLoginNotification];
}

- (void)setupSubViews{
    
    [self addSubview:self.closeBtn];
    [self addSubview:self.iconImgView];
    
    [self addSubview:self.phoneNumberView];
    [self.phoneNumberView addSubview:self.phoneIcon];
    [self.phoneNumberView addSubview:self.phoneTextField];

    [self addSubview:self.passwordView];
    [self.passwordView addSubview:self.passwordIconImgView];
    [self.passwordView addSubview:self.passwordTextField];
    
    [self addSubview:self.loginBtn];
    [self addSubview:self.forgetPassBtn];
    [self addSubview:self.registerBtn];
    
    [self addSubview:self.weChatLoginBtn];
    [self addSubview:self.loginLabel];

}

- (void)layoutSubviews{

    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(KSTATUSBAR_HEIGHT + 10 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@40);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(141 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.equalTo(@(60 * WIDTH_MULTIPLE));
    }];
    
    [_phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_iconImgView.mas_bottom).offset(84 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(_phoneNumberView).offset(10);
        make.bottom.equalTo(_phoneNumberView).offset(-10);
        make.width.equalTo(@30);
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_phoneIcon.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.right.bottom.equalTo(_phoneNumberView);
    }];
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneNumberView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_passwordIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(_passwordView).offset(10);
        make.bottom.equalTo(_passwordView).offset(-10);
        make.width.equalTo(@30);
    }];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_passwordIconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.right.bottom.equalTo(_passwordView);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_passwordView.mas_bottom).offset(24 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
//    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(_loginBtn.mas_bottom).offset(10 * WIDTH_MULTIPLE);
//        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
//        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
//        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
//    }];
    
    [_forgetPassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_loginBtn.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(_loginBtn.mas_right);
        make.height.equalTo(@20);
        
        CGFloat width = [@"忘记密码" widthForFont:KFitFont(13)];
        make.width.equalTo(@(width + 20));
    }];
    
    [_loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    [_weChatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.bottom.equalTo(_loginLabel.mas_top).offset(-17 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@(50 * WIDTH_MULTIPLE));
    }];
    
    [self hideWeChatLoginBtn];
}

- (void)hideWeChatLoginBtn{
    
    if (![WXApi isWXAppInstalled]) {
        
        _weChatLoginBtn.hidden = YES;
        _loginLabel.hidden = YES;
    }
}

#pragma mark - action
- (void)phoneNumEditChanged:(UITextField *)sender{
    
    if (sender == self.phoneTextField) {
        
//        if (sender.text.length > 1) {
//            sender.text = [sender.text substringToIndex:11];
//        }
    }
    else{
        
        if (sender.text.length >= 1) {
            _loginBtn.userInteractionEnabled = YES;
            _loginBtn.backgroundColor = KCOLOR(@"53d76f");
        }
        else{
            _loginBtn.userInteractionEnabled = NO;
            _loginBtn.backgroundColor = KCOLOR(@"c2c2c2");
        }
    }
}

- (void)loginAction{

    if ([self checkLoginInfo]) {
    
        [HYUserHandle userLoginWithPhone:_phoneTextField.text password:_passwordTextField.text complectionBlock:^(BOOL isLoginSuccess) {

            if (isLoginSuccess) {

                self.userLoginSuccess();
            }
        }];
    }
        
//        [HYUserHandle userLoginWithPhone:@"13027104773" password:@"123456" complectionBlock:^(BOOL isLoginSuccess) {
//
//            if (isLoginSuccess) {
//
//                self.userLoginSuccess();
//            }
//        }];
}

- (void)weChatAction{
    
    if ([WXApi isWXAppInstalled]) {
        
        SendAuthReq *req = [SendAuthReq new];
        req.scope = @"snsapi_userinfo";
        req.state = @"com.dacongming";
        [WXApi sendReq:req];
    }
    else{
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"please install WeChat"];
    }
    
}

- (void)weChatLoginCallBack:(NSNotification *)notification{
    
    self.weChatCallbackCode = notification.object;
    NSLog(@"wechatLogin callBack code %@",self.weChatCallbackCode);
    
    NSDictionary *dict = @{@"code" : _weChatCallbackCode};
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_WeChatLogin withParameter:dict isShowHUD:YES success:^(id returnData) {
       
        if (returnData) {
            
            if ([[returnData objectForKey:@"code"] integerValue] == 000) {
                
                NSString *isNewUser = [returnData objectForKey:@"data"][@"isNewUser"];
                NSDictionary *dict = [returnData objectForKey:@"data"];
                HYUserModel *user = [HYUserModel sharedInstance];
                [user modelSetWithDictionary:dict];
                
                [KUSERDEFAULTS setValue:@"weChat" forKey:KUserLoginType];
                [KUSERDEFAULTS synchronize];
                [HYPlistTools archiveObject:user withName:KUserModelData];
                
                if ([isNewUser isEqualToString:@"true"]) {
                    
                    //登录成功 跳转设置密码页面
//                    self.weChatBlock();
                    self.userLoginSuccess();

                }
                else{
                    //老用户，直接跳回首页
                    self.userLoginSuccess();
//                    self.weChatBlock();

                }
                
            }
            else{
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"WeChat login error"];
            }
        }
    }];
}

- (void)closeAction{

    self.loginCloseBlock();
}

- (void)forgetBtnAction{
    
    if (self.forgetPassoword) {
        
        self.forgetPassoword();
    }
}


#pragma mark - request

- (BOOL)checkLoginInfo{
    
    if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text.length == 0) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请输入手机号"];
        return NO;
    }
    else if (![self validatePhoneNum:_phoneTextField.text]){
        
//        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请输入正确的手机号"];
//        return NO;

    }
    else if ([_passwordTextField.text isEqualToString:@""] || _passwordTextField.text.length == 0){
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"密码不能为空"];
        return NO;

    }
    else if (_passwordTextField.text.length < 6){
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"密码不能低于6位"];
        return NO;
    }
    return YES;
}

/** 判断手机号是否有效 */
- (BOOL)validatePhoneNum:(NSString *)phoneNum{
    
    NSString *numReg = @"^(1)\\d{10}$";
    NSPredicate *numCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numReg];
    
    return [numCheck evaluateWithObject:phoneNum];
}

#pragma mark - lazyload
- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIImageView *)iconImgView{

    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgView.image = [UIImage imageNamed:@"loginIcon"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImgView.clipsToBounds = YES;
    }
    return _iconImgView;
}

- (UIView *)phoneNumberView{

    if (!_phoneNumberView) {
        
        _phoneNumberView = [[UIView alloc] initWithFrame:CGRectZero];
        _phoneNumberView.backgroundColor = KAPP_WHITE_COLOR;
        _phoneNumberView.layer.cornerRadius = 3;
    }
    return _phoneNumberView;
}

- (UIImageView *)phoneIcon{
    
    if (!_phoneIcon) {
        
        _phoneIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _phoneIcon.image = [UIImage imageNamed:@"phone"];
        _phoneIcon.contentMode = UIViewContentModeScaleAspectFit;
        _phoneIcon.clipsToBounds = YES;
    }
    return _phoneIcon;
}

- (UITextField *)phoneTextField{
    
    if (!_phoneTextField) {
        
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneTextField.delegate = self;
        
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机账号" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextField.font = KFitFont(14);
        _phoneTextField.textColor = KAPP_272727_COLOR;
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        [_phoneTextField addTarget:self action:@selector(phoneNumEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextField;
}

- (UIView *)passwordView{
    
    if (!_passwordView) {
        
        _passwordView = [[UIView alloc] initWithFrame:CGRectZero];
    
        _passwordView.backgroundColor = KAPP_WHITE_COLOR;
        _passwordView.layer.cornerRadius = 3;
    }
    return _passwordView;
}

- (UIImageView *)passwordIconImgView{
    
    if (!_passwordIconImgView) {
        
        _passwordIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _passwordIconImgView.image = [UIImage imageNamed:@"password"];
        _passwordIconImgView.contentMode = UIViewContentModeScaleAspectFit;
        _passwordIconImgView.clipsToBounds = YES;
    }
    return _passwordIconImgView;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _passwordTextField.delegate = self;
        _passwordTextField.backgroundColor = [UIColor whiteColor];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _passwordTextField.font = KFitFont(14);
        _passwordTextField.textColor = KAPP_272727_COLOR;
        [_passwordTextField addTarget:self action:@selector(phoneNumEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextField;
}

- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = KCOLOR(@"c2c2c2");
        _loginBtn.layer.cornerRadius = 3;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)forgetPassBtn{
    
    if (!_forgetPassBtn) {
        
        _forgetPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPassBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPassBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _forgetPassBtn.titleLabel.font = KFitFont(13);
        [_forgetPassBtn addTarget:self action:@selector(forgetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassBtn;
}

- (UIButton *)registerBtn{
    if (!_registerBtn) {
        
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = KCOLOR(@"53d76f");
        _registerBtn.layer.cornerRadius = 3;
        _registerBtn.layer.masksToBounds = YES;
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIButton *)weChatLoginBtn{
    
    if (!_weChatLoginBtn) {
        
        _weChatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatLoginBtn setImage:[UIImage imageNamed:@"weChatLogo"] forState:UIControlStateNormal];
        [_weChatLoginBtn addTarget:self action:@selector(weChatAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weChatLoginBtn;
}

- (UILabel *)loginLabel{
    
    if (!_loginLabel) {
        
        _loginLabel = [[UILabel alloc] init];
        _loginLabel.text = @"快速登录";
        _loginLabel.font = KFont(16);
        _loginLabel.textColor = KAPP_WHITE_COLOR;
        _loginLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _loginLabel;
}

@end

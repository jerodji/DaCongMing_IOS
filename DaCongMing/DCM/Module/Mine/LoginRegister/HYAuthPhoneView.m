//
//  HYAuthPhoneView.m
//  DaCongMing
//
//

#import "HYAuthPhoneView.h"

@interface HYAuthPhoneView()

/** 白色背景 */
@property (nonatomic,strong) UIView *whiteBgView;
/** 验证码 */
@property (nonatomic,strong) UIButton *getAuthCodeBtn;
/** 线 */
@property (nonatomic,strong) UIView *line1;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;
/** phone */
@property (nonatomic,strong) UILabel *phoneLabel;
/** authCodeLabel */
@property (nonatomic,strong) UILabel *authCodeLabel;

@end

@implementation HYAuthPhoneView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.authCodeLabel];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.getAuthCodeBtn];
    [self addSubview:self.authCodeTextField];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.line1];

}

- (void)layoutSubviews{
    
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(90 * WIDTH_MULTIPLE);
    }];
    
    [_getAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteBgView.mas_top).offset(7 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(90 * WIDTH_MULTIPLE));
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteBgView.mas_top);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(60 * WIDTH_MULTIPLE));
        make.height.equalTo(@(45 * WIDTH_MULTIPLE));
    }];
    
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_phoneLabel);
        make.right.equalTo(self.getAuthCodeBtn.mas_left);
        make.height.equalTo(_phoneLabel);
        make.left.equalTo(_phoneLabel.mas_right).offset(20 * WIDTH_MULTIPLE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(_phoneLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_authCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.width.height.equalTo(_phoneLabel);
        make.top.equalTo(_line1);
    }];
    
    [_authCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_phoneTextField);
        make.top.equalTo(_line1);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView.mas_bottom).offset(50 * WIDTH_MULTIPLE);
        make.height.equalTo(@(50 * WIDTH_MULTIPLE));
    }];
    
    
}

#pragma mark - action
- (void)phoneNumEditChanged:(UITextField *)sender{
    
    if (sender == self.phoneTextField) {
        
        if (sender.text.length >= 11) {
            sender.text = [sender.text substringToIndex:11];
            _getAuthCodeBtn.backgroundColor = KCOLOR(@"53d76f");
            _getAuthCodeBtn.userInteractionEnabled = YES;
        }
        else{
            _getAuthCodeBtn.backgroundColor = KCOLOR(@"b7b7b7");
            _getAuthCodeBtn.userInteractionEnabled = YES;
        }
    }
    
    if (self.phoneTextField.text.length == 11 && self.authCodeTextField.text.length == 6) {
        
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        _confirmBtn.userInteractionEnabled = YES;
    }
    else{
        
         _confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        _confirmBtn.userInteractionEnabled = NO;

    }
    
}

- (void)confirmAction{
    
    [HYUserHandle verifyAuthCodeWithPhone:_phoneTextField.text authCode:_authCodeTextField.text complectionBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            if (self.authPhoneSuccess) {
                
                [HYUserModel sharedInstance].userInfo.phone = _phoneTextField.text;
                self.authPhoneSuccess();
            }
            
        }
        else{
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"验证码错误"];
        }
    }];
}


- (void)getAuthCodeAction{
    
    [self.phoneTextField resignFirstResponder];
    if ([self checkLoginInfo]) {
        
        [HYUserHandle getAuthCodeWithPhone:_phoneTextField.text complectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                //开始倒计时
                [self countDown];
            }
        }];
    }
    
}

#pragma mark - Private Method
- (BOOL)checkLoginInfo{
    
    if ([self.phoneTextField.text isEqualToString:@""] || self.phoneTextField.text.length == 0) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请输入手机号"];
        return NO;
    }
    else if (![self validatePhoneNum:_phoneTextField.text]){
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请输入正确的手机号"];
        return NO;
        
    }
    return YES;
}

/**判断手机号是否有效*/
- (BOOL)validatePhoneNum:(NSString *)phoneNum{
    
    NSString *numReg = @"^(1)\\d{10}$";
    NSPredicate *numCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numReg];
    
    return [numCheck evaluateWithObject:phoneNum];
}

/** 倒计时的方法 */
- (void)countDown{
    
    __block NSInteger time = 59;
    //创建全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建监视时间变化的对象
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        //倒计时结束，关闭
        if (time <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.getAuthCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.getAuthCodeBtn.userInteractionEnabled = YES;
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.getAuthCodeBtn.userInteractionEnabled = NO;
                [self.getAuthCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重试",time] forState:UIControlStateNormal];
                self.getAuthCodeBtn.backgroundColor = KAPP_THEME_COLOR;
                time--;
            });
        }
        
    });
    dispatch_resume(timer);
}

#pragma mark - lazyload
- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _whiteBgView;
}


- (UITextField *)phoneTextField{
    
    if (!_phoneTextField) {
        
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入手机账号" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextField.font = KFitFont(14);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.textColor = KAPP_272727_COLOR;
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
        [_getAuthCodeBtn addTarget:self action:@selector(getAuthCodeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getAuthCodeBtn;
}

- (UIView *)line1{
    
    if (!_line1) {
        
        _line1 = [[UIView alloc] initWithFrame:CGRectZero];
        _line1.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _line1;
}

- (UITextField *)authCodeTextField{
    
    if (!_authCodeTextField) {
        
        _authCodeTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        
        _authCodeTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _authCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
        _authCodeTextField.font = KFitFont(14);
        _authCodeTextField.keyboardType = UIKeyboardTypePhonePad;
        _authCodeTextField.textColor = KAPP_272727_COLOR;
        [_authCodeTextField addTarget:self action:@selector(phoneNumEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _authCodeTextField;
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

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"手机号";
        _phoneLabel.font = KFont(14);
        _phoneLabel.textColor = KAPP_272727_COLOR;
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneLabel;
}

- (UILabel *)authCodeLabel{
    
    if (!_authCodeLabel) {
        
        _authCodeLabel = [[UILabel alloc] init];
        _authCodeLabel.text = @"验证码";
        _authCodeLabel.font = KFont(14);
        _authCodeLabel.textColor = KAPP_272727_COLOR;
        _authCodeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _authCodeLabel;
}

@end

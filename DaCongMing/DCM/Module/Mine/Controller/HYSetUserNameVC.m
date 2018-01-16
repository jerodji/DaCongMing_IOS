//
//  HYSetUserNameVC.m
//  DaCongMing
//
//

#import "HYSetUserNameVC.h"

@interface HYSetUserNameVC ()

/** 设置用户名 */
@property (nonatomic,strong) UITextField *userNameTF;
/** 提示 */
@property (nonatomic,strong) UILabel *tipsLabel;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYSetUserNameVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"设置用户名";
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.userNameTF];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.confirmBtn];
}

- (void)viewDidLayoutSubviews{
    
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_userNameTF);
        make.top.equalTo(_userNameTF.mas_bottom);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_tipsLabel.mas_bottom).offset(30 * WIDTH_MULTIPLE);
        make.left.equalTo(self.view).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-15 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - action
- (void)textChanged:(UITextField *)textField{
    
    if (textField.text.length > 3) {
        
        self.confirmBtn.userInteractionEnabled = YES;
        self.confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        [self.confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
    }
    else{
        
        self.confirmBtn.userInteractionEnabled = NO;
        self.confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        [self.confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
    }
}

- (void)comfirmBtnAction{
    
    
}


#pragma mark - lazyload
- (UITextField *)userNameTF{
    
    if (!_userNameTF) {
        
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _userNameTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"   用户名" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
        _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTF.font = KFitFont(14);
        _userNameTF.textAlignment = NSTextAlignmentLeft;
        _userNameTF.keyboardType = UIKeyboardTypeDefault;
        [_userNameTF setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
        _userNameTF.backgroundColor = KAPP_WHITE_COLOR;
        _userNameTF.textColor = KAPP_272727_COLOR;
        [_userNameTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _userNameTF;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(13);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.text = @"   用户名只能修改一次（3-12个字符）";
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _tipsLabel;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KCOLOR(@"c2c2c2");
        [_confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(16);
        _confirmBtn.layer.cornerRadius = 2;
        _confirmBtn.clipsToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(comfirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

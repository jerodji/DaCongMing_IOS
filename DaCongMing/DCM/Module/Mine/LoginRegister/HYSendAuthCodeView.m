//
//  HYSendAuthCodeView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSendAuthCodeView.h"
#import "HYPasswordView.h"

@interface HYSendAuthCodeView() <HYPasswordViewDelegate>

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
        make.width.mas_equalTo(130 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_authCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_sendAuthBtn.mas_bottom).offset(40 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(46 * WIDTH_MULTIPLE);
    }];
}

- (void)setPhone:(NSString *)phone{
    
    _phone = phone;
    NSString *phoneStr = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _phoneLabel.text = phoneStr;
}

#pragma mark - action
- (void)sendAuthBtnAction{
    
    if (_phone) {
        
        [HYUserHandle getAuthCodeWithPhone:_phone complectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                //开始倒计时
                [self countDown];
            }
        }];
    }
    else{
        
        [HYUserHandle getAuthCodeWithPhone:[HYUserModel sharedInstance].userInfo.phone complectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                //开始倒计时
                [self countDown];
            }
        }];
    }

    
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
                
                [self.sendAuthBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.sendAuthBtn.userInteractionEnabled = YES;
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.sendAuthBtn.userInteractionEnabled = NO;
                [self.sendAuthBtn setTitle:[NSString stringWithFormat:@"验证码(%ld)",time] forState:UIControlStateNormal];
                self.sendAuthBtn.backgroundColor = KAPP_b7b7b7_COLOR;
                time--;
            });
        }
        
    });
    dispatch_resume(timer);
}

#pragma mark - 输入验证码delegate
- (void)passwordCompleteInput:(HYPasswordView *)passwordView{
    
    NSString *authCode = passwordView.passwordString;
    DLog(@"%@",authCode);
    [HYUserHandle verifyAuthCodeWithPhone:[HYUserModel sharedInstance].userInfo.phone authCode:authCode complectionBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            
            if (self.authSuccessBlock) {
                
                self.authSuccessBlock(authCode);
            }
        }
    }];
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
        NSString *phone = [[HYUserModel sharedInstance].userInfo.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _phoneLabel.text = phone;
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
        _sendAuthBtn.titleLabel.font = KFitFont(14);
        [_sendAuthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendAuthBtn addTarget:self action:@selector(sendAuthBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendAuthBtn;
}

- (HYPasswordView *)authCodeView{
    
    if (!_authCodeView) {
        
        _authCodeView = [[HYPasswordView alloc] init];
        _authCodeView.delegate = self;
    }
    return _authCodeView;
}

@end

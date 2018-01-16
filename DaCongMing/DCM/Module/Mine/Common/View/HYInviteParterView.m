//
//  HYInviteParterView.m
//  DaCongMing
//
//

#import "HYInviteParterView.h"

@interface HYInviteParterView()

/** 邀请View */
@property (nonatomic,strong) UIImageView *inviteImgView;
/** 支付按钮 */
@property (nonatomic,strong) UIButton *payBtn;

@property (nonatomic,strong) UIButton *ignoreBtn;

@end

@implementation HYInviteParterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.inviteImgView];
    [_inviteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-KSCREEN_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(250 * WIDTH_MULTIPLE, 330 * WIDTH_MULTIPLE));
    }];
    
    [self addSubview:self.payBtn];
    [self addSubview:self.ignoreBtn];

}

- (void)layoutSubviews{
    
    
    [_ignoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_inviteImgView);
        make.bottom.equalTo(_inviteImgView).offset(-5 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(34 * WIDTH_MULTIPLE);
    }];
    
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_inviteImgView);
        make.bottom.equalTo(_ignoreBtn.mas_top).offset(-5 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(34 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - public
- (void)showInviteView{
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self.inviteImgView mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(self);
        }];
    }];
    
    
}

#pragma mark - action
- (void)ignoreBtnAction{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.inviteImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self).offset(-KSCREEN_HEIGHT);
        }];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)payBtnAction{
    
    if (self.payBlock) {
        
        self.payBlock();
    }
}

#pragma mark - lazyload
- (UIImageView *)inviteImgView{
    
    if (!_inviteImgView) {
        
        _inviteImgView = [UIImageView new];
        _inviteImgView.image = [UIImage imageNamed:@"invite_alert"];
        
    }
    return _inviteImgView;
}

- (UIButton *)payBtn{
    
    if (!_payBtn) {
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.backgroundColor = [UIColor clearColor];
        [_payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

- (UIButton *)ignoreBtn{
    
    if (!_ignoreBtn) {
        
        _ignoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ignoreBtn.backgroundColor = [UIColor clearColor];
        [_ignoreBtn addTarget:self action:@selector(ignoreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ignoreBtn;
}

@end

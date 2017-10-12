//
//  HYShareView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShareView.h"
#import "HYShareHandle.h"

@interface HYShareView()

/** 半透明背景 */
@property (nonatomic,strong) UIView *blackBgView;
/** 白色背景 */
@property (nonatomic,strong) UIView *bgView;
/** WeChat */
@property (nonatomic,strong) HYButton *weChatShareBtn;
/** qq */
@property (nonatomic,strong) HYButton *qqShareBtn;
/** weChatLifeShareBtn */
@property (nonatomic,strong) HYButton *weChatLifeShareBtn;
/** sinaWeiboShareBtn */
@property (nonatomic,strong) HYButton *sinaWeiboShareBtn;
/** 取消 */
@property (nonatomic,strong) UIButton *cancelBtn;

/** line */
@property (nonatomic,strong) UIView *line;

@end

@implementation HYShareView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
                
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            CGPoint tapPoint = [sender locationInView:self];
            if(tapPoint.y < KSCREEN_HEIGHT - 200 * WIDTH_MULTIPLE){
                
                [self hideShareView];
            }
            
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.blackBgView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.weChatShareBtn];
    [self.bgView addSubview:self.qqShareBtn];
    [self.bgView addSubview:self.weChatLifeShareBtn];
    [self.bgView addSubview:self.sinaWeiboShareBtn];
    [self.bgView addSubview:self.cancelBtn];
    [self.bgView addSubview:self.line];
}

- (void)layoutSubviews{
    
    [_blackBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self);
    }];

    
//    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
//        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
//        make.bottom.equalTo(self).offset(200 * WIDTH_MULTIPLE);
//        make.height.equalTo(@(190 * WIDTH_MULTIPLE));
//    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bgView);
        make.right.equalTo(_bgView);
        make.bottom.equalTo(_bgView).offset(-2 * WIDTH_MULTIPLE);;
        make.height.equalTo(@(50 * WIDTH_MULTIPLE));
    }];
    
    CGFloat itemWidth = (KSCREEN_WIDTH - 20 * WIDTH_MULTIPLE) / 4;
    [_weChatShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_bgView).offset(30);
        make.left.equalTo(_bgView);
        make.bottom.equalTo(_cancelBtn.mas_top).offset(-30);
        make.width.equalTo(@(itemWidth));
    }];
    
    [_qqShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_bgView).offset(30);
        make.left.equalTo(_weChatShareBtn.mas_right);
        make.bottom.equalTo(_cancelBtn.mas_top).offset(-30);
        make.width.equalTo(@(itemWidth));
    }];
    
    [_weChatLifeShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_bgView).offset(30);
        make.left.equalTo(_qqShareBtn.mas_right);
        make.bottom.equalTo(_cancelBtn.mas_top).offset(-30);
        make.width.equalTo(@(itemWidth));
    }];
    
    [_sinaWeiboShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_bgView).offset(30);
        make.left.equalTo(_weChatLifeShareBtn.mas_right);
        make.bottom.equalTo(_cancelBtn.mas_top).offset(-30);
        make.width.equalTo(@(itemWidth));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_bgView);
        make.top.equalTo(_cancelBtn);
        make.height.equalTo(@1);
    }];
}

#pragma mark - action
- (void)weChatShareBtnAction{
    
    if (self.shareDict) {
        
        [HYShareHandle shareToWeChatWithDict:self.shareDict];
    }
}

- (void)lifeCircleShareBtnAction{
    
    if (self.shareDict) {
        
        [HYShareHandle shareToLifeCircleWithDict:self.shareDict];
    }
}

- (void)cancelShareAction{
    
    [self hideShareView];
}

- (void)hideShareView{
    
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}

#pragma mark - PublicMethod
- (void)showShareView{
    
    [self setupSubviews];
    [UIView animateWithDuration:0.25 animations:^{
        
        _blackBgView.alpha = 0.6;
        _bgView.frame = CGRectMake(10 * WIDTH_MULTIPLE, KSCREEN_HEIGHT - 200 * WIDTH_MULTIPLE, KSCREEN_WIDTH - 20 * WIDTH_MULTIPLE, 190 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIView *)blackBgView{
    
    if (!_blackBgView) {
        
        _blackBgView = [UIView new];
        _blackBgView.backgroundColor = KAPP_BLACK_COLOR;
        _blackBgView.alpha = 0;
    }
    return _blackBgView;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.frame = CGRectMake(10 * WIDTH_MULTIPLE, KSCREEN_HEIGHT, KSCREEN_WIDTH - 20 * WIDTH_MULTIPLE, 190 * WIDTH_MULTIPLE);
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
        _bgView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (HYButton *)weChatShareBtn{
    
    if (!_weChatShareBtn) {
        
        _weChatShareBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_weChatShareBtn setImage:[UIImage imageNamed:@"share_weChat"] forState:UIControlStateNormal];
        [_weChatShareBtn setTitle:@"微信好友" forState:UIControlStateNormal];
        [_weChatShareBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _weChatShareBtn.titleLabel.font = KFitFont(14);
        [_weChatShareBtn addTarget:self action:@selector(weChatShareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weChatShareBtn;
}

- (HYButton *)qqShareBtn{
    
    if (!_qqShareBtn) {
        
        _qqShareBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_qqShareBtn setImage:[UIImage imageNamed:@"share_qq"] forState:UIControlStateNormal];
        [_qqShareBtn setTitle:@"QQ好友" forState:UIControlStateNormal];
        [_qqShareBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _qqShareBtn.titleLabel.font = KFitFont(14);

        [_qqShareBtn addTarget:self action:@selector(weChatShareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqShareBtn;
}

- (HYButton *)weChatLifeShareBtn{
    
    if (!_weChatLifeShareBtn) {
        
        _weChatLifeShareBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_weChatLifeShareBtn setImage:[UIImage imageNamed:@"share_weChatLife"] forState:UIControlStateNormal];
        [_weChatLifeShareBtn setTitle:@"微信朋友圈" forState:UIControlStateNormal];
        [_weChatLifeShareBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _weChatLifeShareBtn.titleLabel.font = KFitFont(14);

        [_weChatLifeShareBtn addTarget:self action:@selector(lifeCircleShareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weChatLifeShareBtn;
}

- (HYButton *)sinaWeiboShareBtn{
    
    if (!_sinaWeiboShareBtn) {
        
        _sinaWeiboShareBtn = [HYButton buttonWithType:UIButtonTypeCustom];
        [_sinaWeiboShareBtn setImage:[UIImage imageNamed:@"share_sina"] forState:UIControlStateNormal];
        [_sinaWeiboShareBtn setTitle:@"新浪微博" forState:UIControlStateNormal];
        [_sinaWeiboShareBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _sinaWeiboShareBtn.titleLabel.font = KFitFont(14);
        [_sinaWeiboShareBtn addTarget:self action:@selector(weChatShareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sinaWeiboShareBtn;
}

- (UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_cancelBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = KFitFont(16);
        [_cancelBtn addTarget:self action:@selector(cancelShareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)line{
    
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _line;
}

@end

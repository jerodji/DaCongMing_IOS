//
//  PayModeView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/30.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "PayModeView.h"

@interface PayModeView()
@property (nonatomic,strong) BuyButton * aiBtn;
@property (nonatomic,strong) BuyButton * wechatBtn;
@property (nonatomic,strong) BuyButton * uniBtn;
@end

@implementation PayModeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = 100.f * WIDTH_MULTIPLE;
        CGFloat height = 110.f * WIDTH_MULTIPLE;
        CGFloat distance = (frame.size.width - width*3)/4;
        
        /**
         * 支付宝btn
         */
        _aiBtn = [BuyButton buttonWithType:UIButtonTypeCustom];
        _aiBtn.frame = CGRectMake( distance, 0, width, height);
        [_aiBtn setImage:[UIImage imageNamed:@"zhifub"] forState:UIControlStateNormal];
        [_aiBtn setTitle:@"支付宝" forState:UIControlStateNormal];
        _aiBtn.layer.cornerRadius = 8;
        [_aiBtn addTarget:self action:@selector(aiAction) forControlEvents:UIControlEventTouchUpInside];
        [_aiBtn setTitleColor:UIColorRGB(104, 104, 104) forState:UIControlStateNormal];
        _aiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _aiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_aiBtn];
        
        _aiBtn.layer.borderWidth = 1;
        _aiBtn.layer.borderColor = UIColorRGB(56, 173, 152).CGColor;
        _wechatBtn.layer.borderWidth = 0;
        _uniBtn.layer.borderWidth = 0;
        _paymode = PayModeAliPay;
        
        /**
         * 微信btn
         */
        _wechatBtn = [BuyButton buttonWithType:UIButtonTypeCustom];
        _wechatBtn.frame = CGRectMake( _aiBtn.right + distance, 0, width, height);
        [_wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        [_wechatBtn setTitle:@"微信" forState:UIControlStateNormal];
        [_wechatBtn setTitleColor:UIColorRGB(104, 104, 104) forState:UIControlStateNormal];
        _wechatBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _wechatBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _wechatBtn.layer.cornerRadius = 8;
        [_wechatBtn addTarget:self action:@selector(wechatAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_wechatBtn];
        
        /**
         * 银联线下支付btn
         */
        _uniBtn = [BuyButton buttonWithType:UIButtonTypeCustom];
        _uniBtn.frame = CGRectMake(_wechatBtn.right + distance, 0, width, height);
        [_uniBtn setImage:[UIImage imageNamed:@"bankcard"] forState:UIControlStateNormal];
        [_uniBtn setTitle:@"银联" forState:UIControlStateNormal];
        [_uniBtn setTitleColor:UIColorRGB(104, 104, 104) forState:UIControlStateNormal];
        _uniBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _uniBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _uniBtn.layer.cornerRadius = 8;
        [_uniBtn addTarget:self action:@selector(uniAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_uniBtn];
    }
    return self;
}

- (void)aiAction {
    _aiBtn.layer.borderWidth = 1;
    _aiBtn.layer.borderColor = UIColorRGB(56, 173, 152).CGColor;
    _wechatBtn.layer.borderWidth = 0;
    _uniBtn.layer.borderWidth = 0;
    _paymode = PayModeAliPay;
    !_actionCB ? : _actionCB(PayModeAliPay);
}
- (void)wechatAction {
    _wechatBtn.layer.borderWidth = 1;
    _wechatBtn.layer.borderColor = UIColorRGB(56, 173, 152).CGColor;
    _uniBtn.layer.borderWidth = 0;
    _aiBtn.layer.borderWidth = 0;
    _paymode = PayModeWeChat;
    !_actionCB ? : _actionCB(PayModeWeChat);
}
- (void)uniAction {
    _uniBtn.layer.borderWidth = 1;
    _uniBtn.layer.borderColor = UIColorRGB(56, 173, 152).CGColor;
    _aiBtn.layer.borderWidth = 0;
    _wechatBtn.layer.borderWidth = 0;
    _paymode = PayModeUniPay;
    !_actionCB ? : _actionCB(PayModeUniPay);
}

@end

#pragma mark- /********************* BuyButton *********************/
@interface BuyButton()
@end
@implementation BuyButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(13 *WIDTH_MULTIPLE, 10 *WIDTH_MULTIPLE, 74 *WIDTH_MULTIPLE, 74 *WIDTH_MULTIPLE);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, (self.size.height-25), self.size.width, 25);
}

@end

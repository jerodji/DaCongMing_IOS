//
//  HYReceiverInfoTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReceiverInfoTableViewCell.h"

@interface HYReceiverInfoTableViewCell()

/** 收货人 */
@property (nonatomic,strong) UILabel *receiverLabel;
/** phoneNum */
@property (nonatomic,strong) UILabel *phoneNumLabel;
/** addressLabel */
@property (nonatomic,strong) UILabel *addressLabel;

/** lookOrderBtn */
@property (nonatomic,strong) UIButton *lookOrderBtn;
/** returnHomeBtn */
@property (nonatomic,strong) UIButton *returnHomeBtn;
/** payAgainBtn */
@property (nonatomic,strong) UIButton *payAgainBtn;

@end

@implementation HYReceiverInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.receiverLabel];
    [self addSubview:self.phoneNumLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.lookOrderBtn];
    [self addSubview:self.returnHomeBtn];
    [self addSubview:self.payAgainBtn];
    
}

#pragma mark - action
- (void)lookPayOrderAction{
    
    if (self.lookOrderInfo) {
        self.lookOrderInfo();
    }
}

- (void)returnHomeAction{
    
    if (self.returnHome) {
        self.returnHome();
    }
}

- (void)payAgainAction{
    
    if (self.payAgain) {
        self.payAgain();
    }
}

- (void)layoutSubviews{
    
    [_receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(25 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.equalTo(@20);
    }];
     
    [_phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.width.height.equalTo(_receiverLabel);
         make.top.equalTo(_receiverLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
     }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_receiverLabel);
        make.top.equalTo(_phoneNumLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.height.equalTo(@40);
    }];
    
    [_lookOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self).offset(-18 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(55 * WIDTH_MULTIPLE);
        make.width.equalTo(@(110 * WIDTH_MULTIPLE));
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_returnHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.height.width.equalTo(_lookOrderBtn);
        make.right.equalTo(self).offset(-55 * WIDTH_MULTIPLE);
    }];
    
    [_payAgainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.top.equalTo(_returnHomeBtn);
    }];
}

#pragma mark - setter
- (void)setIsPaySuccess:(BOOL)isPaySuccess{
    
    _isPaySuccess = isPaySuccess;
    
    if (isPaySuccess) {
        _payAgainBtn.hidden = YES;
    }
    else{
        _returnHomeBtn.hidden = YES;
    }
}

- (void)setAddressMap:(HYAddressMap *)addressMap{
    
    _addressMap = addressMap;
    
    _receiverLabel.text = [NSString stringWithFormat:@"收货人:%@",addressMap.receiver];
    _phoneNumLabel.text = [NSString stringWithFormat:@"手机号:%@",addressMap.phoneNum];
    _addressLabel.text = [NSString stringWithFormat:@"收货地址:%@%@%@%@",addressMap.province,addressMap.city,addressMap.area,addressMap.address];
}

#pragma mark - lazyload
- (UILabel *)receiverLabel{
    
    if (!_receiverLabel) {
        
        _receiverLabel = [[UILabel alloc] init];
        _receiverLabel.font = KFitFont(14);
        _receiverLabel.textAlignment = NSTextAlignmentLeft;
        _receiverLabel.text = @"收货人:哈罗德";
        _receiverLabel.textColor = KAPP_272727_COLOR;
    }
    return _receiverLabel;
}

- (UILabel *)phoneNumLabel{
    
    if (!_phoneNumLabel) {
        
        _phoneNumLabel = [[UILabel alloc] init];
        _phoneNumLabel.font = KFitFont(14);
        _phoneNumLabel.textAlignment = NSTextAlignmentLeft;
        _phoneNumLabel.text = @"手机号:1301401501";
        _phoneNumLabel.textColor = KAPP_272727_COLOR;
    }
    return _phoneNumLabel;
}

- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = KFitFont(14);
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.text = @"收货地址:暂无收货地址，点击添加新地址";
        _addressLabel.textColor = KAPP_272727_COLOR;
        _addressLabel.numberOfLines = 0;
        
    }
    return _addressLabel;
}

- (UIButton *)lookOrderBtn{
    
    if (!_lookOrderBtn) {
        
        _lookOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        _lookOrderBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_lookOrderBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _lookOrderBtn.titleLabel.font = KFitFont(14);
        _lookOrderBtn.layer.borderColor = KAPP_7b7b7b_COLOR.CGColor;
        _lookOrderBtn.layer.borderWidth = 1;
        _lookOrderBtn.layer.cornerRadius = 4;
        _lookOrderBtn.clipsToBounds = YES;
        [_lookOrderBtn addTarget:self action:@selector(lookPayOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookOrderBtn;
}

- (UIButton *)returnHomeBtn{
    
    if (!_returnHomeBtn) {
        
        _returnHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnHomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        _returnHomeBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_returnHomeBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
        _returnHomeBtn.titleLabel.font = KFitFont(14);
        _returnHomeBtn.layer.borderColor = KAPP_THEME_COLOR.CGColor;
        _returnHomeBtn.layer.borderWidth = 1;
        _returnHomeBtn.layer.cornerRadius = 4;
        _returnHomeBtn.clipsToBounds = YES;
        [_returnHomeBtn addTarget:self action:@selector(returnHomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnHomeBtn;
}

- (UIButton *)payAgainBtn{
    
    if (!_payAgainBtn) {
        
        _payAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payAgainBtn setTitle:@"重新支付" forState:UIControlStateNormal];
        _payAgainBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_payAgainBtn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
        _payAgainBtn.titleLabel.font = KFitFont(14);
        _payAgainBtn.layer.borderColor = KAPP_THEME_COLOR.CGColor;
        _payAgainBtn.layer.borderWidth = 1;
        _payAgainBtn.layer.cornerRadius = 4;
        _payAgainBtn.clipsToBounds = YES;
        [_payAgainBtn addTarget:self action:@selector(payAgainAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payAgainBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HYReceiveAddressTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReceiveAddressTableViewCell.h"

@interface HYReceiveAddressTableViewCell()

/** 条 */
@property (nonatomic,strong) UIImageView *stripImgView;
/** 收货人 */
@property (nonatomic,strong) UILabel *nameLabel;
/** 电话 */
@property (nonatomic,strong) UILabel *phoneLabel;
/** 收货地址 */
@property (nonatomic,strong) UILabel *addressLabel;
/** 默认 */
@property (nonatomic,strong) UILabel *defaultLabel;
/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYReceiveAddressTableViewCell

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
    
    [self addSubview:self.stripImgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.defaultLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.bottomLine];

}

#pragma mark - setter
- (void)setOrderModel:(HYCreateOrder *)orderModel{
    
    _orderModel = orderModel;
    
    _nameLabel.text = orderModel.addressMap.receiver;
    _phoneLabel.text = orderModel.addressMap.phoneNum;
    _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",orderModel.addressMap.province,orderModel.addressMap.city,orderModel.addressMap.area,orderModel.addressMap.address];
    [_addressLabel sizeToFit];

}

- (void)layoutSubviews{
    
    [_stripImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(8 * WIDTH_MULTIPLE);
        make.height.equalTo(@(7 * WIDTH_MULTIPLE));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_stripImgView).offset(20 * WIDTH_MULTIPLE);
        make.height.equalTo(@20);
        make.width.equalTo(@(65 * WIDTH_MULTIPLE));
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.height.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right);
        make.right.equalTo(self);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_phoneLabel);
        make.top.equalTo(_phoneLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self);
    }];
    
    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.height.equalTo(_nameLabel);
        make.top.equalTo(_addressLabel);
        make.width.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(20 / 1.77));
        make.centerY.equalTo(self).offset(8 * WIDTH_MULTIPLE);
        make.height.equalTo(@(20));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [_addressLabel layoutIfNeeded];

}

#pragma mark - lazyload
- (UIImageView *)stripImgView{
    
    if (!_stripImgView) {
        
        _stripImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_strip"]];
        _stripImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stripImgView;
}

- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = KFitFont(15);
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.text = @"暂无收货地址，点击添加新地址";
        _addressLabel.textColor = KCOLOR(@"7b7b7b");
        _addressLabel.numberOfLines = 0;
        
    }
    return _addressLabel;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = KFitFont(14);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"哈罗德";
        _nameLabel.textColor = KAPP_272727_COLOR;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = KFitFont(14);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.text = @"1101201301";
        _phoneLabel.textColor = KAPP_272727_COLOR;
    }
    return _phoneLabel;
}

- (UILabel *)defaultLabel{
    
    if (!_defaultLabel) {
        
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.font = KFitFont(14);
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.text = @"默认";
        _defaultLabel.textColor = KAPP_PRICE_COLOR;
        _defaultLabel.layer.cornerRadius = 6;
        _defaultLabel.layer.borderColor = KAPP_PRICE_COLOR.CGColor;
        _defaultLabel.layer.borderWidth = 1;
        _defaultLabel.clipsToBounds = YES;
    }
    return _defaultLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

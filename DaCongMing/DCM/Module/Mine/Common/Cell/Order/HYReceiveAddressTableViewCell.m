//
//  HYReceiveAddressTableViewCell.m
//  DaCongMing
//
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

/** 无收货地址 */
@property (nonatomic,strong) UIImageView *noAddressImgView;
/** 默认 */
@property (nonatomic,strong) UILabel *tipsLabel;

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

    [self addSubview:self.noAddressImgView];
    [self addSubview:self.tipsLabel];
}

#pragma mark - setter
- (void)setOrderModel:(HYCreateOrder *)orderModel{
    
    _orderModel = orderModel;
    
    if ([orderModel.addressMap.receiver isNotBlank]) {
        //有收货地址
        _nameLabel.text = orderModel.addressMap.receiver;
        _phoneLabel.text = orderModel.addressMap.phoneNum;
        _addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",orderModel.addressMap.province,orderModel.addressMap.city,orderModel.addressMap.area,orderModel.addressMap.address];
        [_addressLabel sizeToFit];
        
        self.noAddressImgView.hidden = YES;
        self.tipsLabel.hidden = YES;
        _phoneLabel.hidden = NO;
        _nameLabel.hidden = NO;
        _addressLabel.hidden = NO;
        _defaultLabel.hidden = NO;
    }
    else{
        //没有收货地址
        _phoneLabel.hidden = YES;
        _nameLabel.hidden = YES;
        _addressLabel.hidden = YES;
        _defaultLabel.hidden = YES;
        self.noAddressImgView.hidden = NO;
        self.tipsLabel.hidden = NO;
    }

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
        make.width.equalTo(@(80 * WIDTH_MULTIPLE));
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
        make.width.equalTo(@(40 * WIDTH_MULTIPLE));
        make.centerY.equalTo(_addressLabel);
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
    
    [_noAddressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(40 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self).offset(8 * WIDTH_MULTIPLE);;
        make.size.mas_equalTo(CGSizeMake(30 * WIDTH_MULTIPLE, 30 * WIDTH_MULTIPLE));
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self).offset(8 * WIDTH_MULTIPLE);
        make.left.equalTo(_noAddressImgView.mas_right).offset(20 * WIDTH_MULTIPLE);
        make.right.equalTo(_arrowImgView.mas_left).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];

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

- (UIImageView *)noAddressImgView{
    
    if (!_noAddressImgView) {
        
        _noAddressImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_mark"]];
        _noAddressImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _noAddressImgView;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.text = @"暂无收货地址，点击添加收货地址";
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _tipsLabel;
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

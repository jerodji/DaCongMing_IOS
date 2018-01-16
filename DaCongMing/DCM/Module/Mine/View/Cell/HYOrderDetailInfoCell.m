//
//  HYOrderDetailInfoCell.m
//  DaCongMing
//
//

#import "HYOrderDetailInfoCell.h"

@interface HYOrderDetailInfoCell()

/** 订单状态 */
@property (nonatomic,strong) UILabel *stateLabel;
/** 金额 */
@property (nonatomic,strong) UILabel *amountLabel;
/** discountAmountLabel */
@property (nonatomic,strong) UILabel *discountAmountLabel;
/** 邮费 */
@property (nonatomic,strong) UILabel *postLabel;
/** receivedAddressLabel */
@property (nonatomic,strong) UILabel *receivedAddressLabel;
/** 收货人 */
@property (nonatomic,strong) UILabel *receiverLabel;
/** telLabel */
@property (nonatomic,strong) UILabel *telLabel;
/** 下单时间 */
@property (nonatomic,strong) UILabel *orderTimeLabel;
/** 订单号 */
@property (nonatomic,strong) UILabel *orderNumberLabel;
/** 商品信息 */
@property (nonatomic,strong) UILabel *orderInfoLabel;

/** 订单状态 */
@property (nonatomic,strong) UILabel *stateValueLabel;
/** 金额 */
@property (nonatomic,strong) UILabel *amountValueLabel;
/** discountAmountLabel */
@property (nonatomic,strong) UILabel *discountAmountValueLabel;
/** 邮费 */
@property (nonatomic,strong) UILabel *postValueLabel;
/** receivedAddressLabel */
@property (nonatomic,strong) UILabel *receivedAddressValueLabel;
/** 收货人 */
@property (nonatomic,strong) UILabel *receiverValueLabel;
/** telLabel */
@property (nonatomic,strong) UILabel *telValueLabel;
/** 下单时间 */
@property (nonatomic,strong) UILabel *orderTimeValueLabel;
/** 订单号 */
@property (nonatomic,strong) UILabel *orderNumberValueLabel;

@end

@implementation HYOrderDetailInfoCell

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
    
    [self addSubview:self.stateLabel];
    [self addSubview:self.amountLabel];
    [self addSubview:self.discountAmountLabel];
    [self addSubview:self.postLabel];
    [self addSubview:self.receivedAddressLabel];
    [self addSubview:self.receiverLabel];
    [self addSubview:self.telLabel];
    [self addSubview:self.orderTimeLabel];
    [self addSubview:self.orderNumberLabel];
    
    [self addSubview:self.stateValueLabel];
    [self addSubview:self.amountValueLabel];
    [self addSubview:self.discountAmountValueLabel];
    [self addSubview:self.postValueLabel];
    [self addSubview:self.receivedAddressValueLabel];
    [self addSubview:self.receiverValueLabel];
    [self addSubview:self.telValueLabel];
    [self addSubview:self.orderTimeValueLabel];
    [self addSubview:self.orderNumberValueLabel];

    [self addSubview:self.orderInfoLabel];
}

- (void)layoutSubviews{
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(19 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(80 * WIDTH_MULTIPLE, 20 * WIDTH_MULTIPLE));
    }];
    
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_stateLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_discountAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_amountLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_postLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_discountAmountLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_receivedAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_postLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_receivedAddressLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_receiverLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_telLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_stateLabel);
        make.top.equalTo(_orderTimeLabel.mas_bottom).offset(14 * WIDTH_MULTIPLE);
    }];
    
    [_orderInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_orderNumberLabel);
        make.bottom.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self layoutValueLabel];
}

- (void)layoutValueLabel{
    
    [_stateValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_stateLabel.mas_right).offset(5 * WIDTH_MULTIPLE);
        make.top.height.equalTo(_stateLabel);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
    }];
    
    [_amountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_amountLabel);
    }];
    
    [_discountAmountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_discountAmountLabel);
    }];
    
    [_postValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_postLabel);
    }];
    
    [_receivedAddressValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_receivedAddressLabel);
    }];
    
    [_receiverValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_receiverLabel);
    }];
    
    [_telValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_telLabel);
    }];
    
    [_orderTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_orderTimeLabel);
    }];
    
    [_orderNumberValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.height.equalTo(_stateValueLabel);
        make.top.equalTo(_orderNumberLabel);
    }];
}

#pragma mark - lazyload
- (UILabel *)stateLabel{
    
    if (!_stateLabel) {
        
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = KFitFont(14);
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.text = @"订单状态:";
        _stateLabel.textColor = KAPP_7b7b7b_COLOR;
        _stateLabel.numberOfLines = 0;
    }
    return _stateLabel;
}

- (UILabel *)amountLabel{
    
    if (!_amountLabel) {
        
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.font = KFitFont(14);
        _amountLabel.textAlignment = NSTextAlignmentLeft;
        _amountLabel.text = @"总额";
        _amountLabel.textColor = KAPP_7b7b7b_COLOR;
        _amountLabel.numberOfLines = 0;
    }
    return _amountLabel;
}

- (UILabel *)discountAmountLabel{
    
    if (!_discountAmountLabel) {
        
        _discountAmountLabel = [[UILabel alloc] init];
        _discountAmountLabel.font = KFitFont(14);
        _discountAmountLabel.textAlignment = NSTextAlignmentLeft;
        _discountAmountLabel.text = @"优惠金额:";
        _discountAmountLabel.textColor = KAPP_7b7b7b_COLOR;
        _discountAmountLabel.numberOfLines = 0;
    }
    return _discountAmountLabel;
}

- (UILabel *)postLabel{
    
    if (!_postLabel) {
        
        _postLabel = [[UILabel alloc] init];
        _postLabel.font = KFitFont(14);
        _postLabel.textAlignment = NSTextAlignmentLeft;
        _postLabel.text = @"运费:";
        _postLabel.textColor = KAPP_7b7b7b_COLOR;
        _postLabel.numberOfLines = 0;
    }
    return _postLabel;
}

- (UILabel *)receivedAddressLabel{
    
    if (!_receivedAddressLabel) {
        
        _receivedAddressLabel = [[UILabel alloc] init];
        _receivedAddressLabel.font = KFitFont(14);
        _receivedAddressLabel.textAlignment = NSTextAlignmentLeft;
        _receivedAddressLabel.text = @"配送至:";
        _receivedAddressLabel.textColor = KAPP_7b7b7b_COLOR;
        _receivedAddressLabel.numberOfLines = 0;
    }
    return _receivedAddressLabel;
}

- (UILabel *)receiverLabel{
    
    if (!_receiverLabel) {
        
        _receiverLabel = [[UILabel alloc] init];
        _receiverLabel.font = KFitFont(14);
        _receiverLabel.textAlignment = NSTextAlignmentLeft;
        _receiverLabel.text = @"收货人:";
        _receiverLabel.textColor = KAPP_7b7b7b_COLOR;
        _receiverLabel.numberOfLines = 0;
    }
    return _receiverLabel;
}

- (UILabel *)telLabel{
    
    if (!_telLabel) {
        
        _telLabel = [[UILabel alloc] init];
        _telLabel.font = KFitFont(14);
        _telLabel.textAlignment = NSTextAlignmentLeft;
        _telLabel.text = @"电话:";
        _telLabel.textColor = KAPP_7b7b7b_COLOR;
        _telLabel.numberOfLines = 0;
    }
    return _telLabel;
}

- (UILabel *)orderTimeLabel{
    
    if (!_orderTimeLabel) {
        
        _orderTimeLabel = [[UILabel alloc] init];
        _orderTimeLabel.font = KFitFont(14);
        _orderTimeLabel.textAlignment = NSTextAlignmentLeft;
        _orderTimeLabel.text = @"下单时间:";
        _orderTimeLabel.textColor = KAPP_7b7b7b_COLOR;
        _orderTimeLabel.numberOfLines = 0;
    }
    return _orderTimeLabel;
}

- (UILabel *)orderNumberLabel{
    
    if (!_orderNumberLabel) {
        
        _orderNumberLabel = [[UILabel alloc] init];
        _orderNumberLabel.font = KFitFont(14);
        _orderNumberLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumberLabel.text = @"下单编号:";
        _orderNumberLabel.textColor = KAPP_7b7b7b_COLOR;
        _orderNumberLabel.numberOfLines = 0;
    }
    return _orderNumberLabel;
}

#pragma mark - setter
- (void)setOrderModel:(HYMyOrderModel *)orderModel{
    
    _orderModel = orderModel;
    NSString *state = [orderModel.order_stat integerValue] == 1 ? @"未付款" : [orderModel.order_stat integerValue] == 2 ? @"未发货" : [orderModel.order_stat integerValue] == 3 ? @"待收货" : [orderModel.order_stat integerValue] == 8 ? @"已收货" : @"未知";
    _stateValueLabel.text = state;
    _amountValueLabel.text = [NSString stringWithFormat:@"￥%@",orderModel.summary_price];
    _discountAmountValueLabel.text = [NSString stringWithFormat:@"￥%@",orderModel.ispassentry];
    _postValueLabel.text = [NSString stringWithFormat:@"￥%@",@"0.00"];;
    _receivedAddressValueLabel.text = [NSString stringWithFormat:@"%@%@%@%@",orderModel.province_name,orderModel.city_name,orderModel.area_name,orderModel.address];
    _receiverValueLabel.text = orderModel.receiver;
    _telValueLabel.text = orderModel.phoneNum;
    _orderTimeValueLabel.text = orderModel.create_time;
    _orderNumberValueLabel.text = orderModel.sorder_id;
    
}

#pragma mark - valueLabel
- (UILabel *)stateValueLabel{
    
    if (!_stateValueLabel) {
        
        _stateValueLabel = [[UILabel alloc] init];
        _stateValueLabel.font = KFitFont(14);
        _stateValueLabel.textAlignment = NSTextAlignmentLeft;
        _stateValueLabel.text = @"已收货";
        _stateValueLabel.textColor = KAPP_PRICE_COLOR;
        _stateValueLabel.numberOfLines = 0;
    }
    return _stateValueLabel;
}

- (UILabel *)amountValueLabel{
    
    if (!_amountValueLabel) {
        
        _amountValueLabel = [[UILabel alloc] init];
        _amountValueLabel.font = KFitFont(14);
        _amountValueLabel.textAlignment = NSTextAlignmentLeft;
        _amountValueLabel.text = @"0.00";
        _amountValueLabel.textColor = KAPP_PRICE_COLOR;
        _amountValueLabel.numberOfLines = 0;
    }
    return _amountValueLabel;
}

- (UILabel *)discountAmountValueLabel{
    
    if (!_discountAmountValueLabel) {
        
        _discountAmountValueLabel = [[UILabel alloc] init];
        _discountAmountValueLabel.font = KFitFont(14);
        _discountAmountValueLabel.textAlignment = NSTextAlignmentLeft;
        _discountAmountValueLabel.text = @"0.00";
        _discountAmountValueLabel.textColor = KAPP_PRICE_COLOR;
        _discountAmountValueLabel.numberOfLines = 0;
    }
    return _discountAmountValueLabel;
}

- (UILabel *)postValueLabel{
    
    if (!_postValueLabel) {
        
        _postValueLabel = [[UILabel alloc] init];
        _postValueLabel.font = KFitFont(14);
        _postValueLabel.textAlignment = NSTextAlignmentLeft;
        _postValueLabel.text = @"20.00";
        _postValueLabel.textColor = KAPP_PRICE_COLOR;
        _postValueLabel.numberOfLines = 0;
    }
    return _postValueLabel;
}

- (UILabel *)receivedAddressValueLabel{
    
    if (!_receivedAddressValueLabel) {
        
        _receivedAddressValueLabel = [[UILabel alloc] init];
        _receivedAddressValueLabel.font = KFitFont(14);
        _receivedAddressValueLabel.textAlignment = NSTextAlignmentLeft;
        _receivedAddressValueLabel.text = @"上海市松江区";
        _receivedAddressValueLabel.textColor = KAPP_272727_COLOR;
        _receivedAddressValueLabel.numberOfLines = 0;
    }
    return _receivedAddressValueLabel;
}

- (UILabel *)receiverValueLabel{
    
    if (!_receiverValueLabel) {
        
        _receiverValueLabel = [[UILabel alloc] init];
        _receiverValueLabel.font = KFitFont(14);
        _receiverValueLabel.textAlignment = NSTextAlignmentLeft;
        _receiverValueLabel.text = @"收货人:";
        _receiverValueLabel.textColor = KAPP_7b7b7b_COLOR;
        _receiverValueLabel.numberOfLines = 0;
    }
    return _receiverValueLabel;
}

- (UILabel *)telValueLabel{
    
    if (!_telValueLabel) {
        
        _telValueLabel = [[UILabel alloc] init];
        _telValueLabel.font = KFitFont(14);
        _telValueLabel.textAlignment = NSTextAlignmentLeft;
        _telValueLabel.text = @"121121121121";
        _telValueLabel.textColor = KCOLOR(@"5fc6ef");
        _telValueLabel.numberOfLines = 0;
    }
    return _telValueLabel;
}

- (UILabel *)orderTimeValueLabel{
    
    if (!_orderTimeValueLabel) {
        
        _orderTimeValueLabel = [[UILabel alloc] init];
        _orderTimeValueLabel.font = KFitFont(14);
        _orderTimeValueLabel.textAlignment = NSTextAlignmentLeft;
        _orderTimeValueLabel.text = @"下单时间:";
        _orderTimeValueLabel.textColor = KAPP_7b7b7b_COLOR;
        _orderTimeValueLabel.numberOfLines = 0;
    }
    return _orderTimeValueLabel;
}

- (UILabel *)orderNumberValueLabel{
    
    if (!_orderNumberValueLabel) {
        
        _orderNumberValueLabel = [[UILabel alloc] init];
        _orderNumberValueLabel.font = KFitFont(14);
        _orderNumberValueLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumberValueLabel.text = @"下单编号:";
        _orderNumberValueLabel.textColor = KAPP_7b7b7b_COLOR;
        _orderNumberValueLabel.numberOfLines = 0;
    }
    return _orderNumberValueLabel;
}

- (UILabel *)orderInfoLabel{
    
    if (!_orderInfoLabel) {
        
        _orderInfoLabel = [[UILabel alloc] init];
        _orderInfoLabel.font = KFitFont(16);
        _orderInfoLabel.textAlignment = NSTextAlignmentLeft;
        _orderInfoLabel.text = @"商品信息";
        _orderInfoLabel.textColor = KAPP_272727_COLOR;
        _orderInfoLabel.numberOfLines = 0;
    }
    return _orderInfoLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end




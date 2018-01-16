//
//  HYSaleAfterCell.m
//  DaCongMing
//
//

#import "HYSaleAfterCell.h"

@interface HYSaleAfterCell()

/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;
/** shopLabel */
@property (nonatomic,strong) UILabel *shopLabel;
/** 订单 */
@property (nonatomic,strong) UILabel *orderIDLabel;
/** 商品icon */
@property (nonatomic,strong) UIImageView *itemImgView;
/** 商品名字Label */
@property (nonatomic,strong) UILabel *itemLabel;
/** 规格 */
@property (nonatomic,strong) UILabel *unitLabel;
/** 商品总数 */
@property (nonatomic,strong) UILabel *goodsCountLabel;
/** topLine */
@property (nonatomic,strong) UIView *topLine;
/** middleLine */
@property (nonatomic,strong) UIView *middleLine;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;
/** pricelabel */
@property (nonatomic,strong) UILabel *priceLabel;
/** 退款状态   */
@property (nonatomic,strong) UILabel *refundStateLabel;

@end

@implementation HYSaleAfterCell


- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.iconImgView];
    [self addSubview:self.shopLabel];
    [self addSubview:self.orderIDLabel];
    [self addSubview:self.goodsCountLabel];
    [self addSubview:self.itemImgView];
    [self addSubview:self.itemLabel];
    [self addSubview:self.unitLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.middleLine];
    [self addSubview:self.topLine];
    [self addSubview:self.priceLabel];
    [self addSubview:self.refundStateLabel];
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bgView).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_bgView).offset(5 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@20);
    }];
    
    [_orderIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(_iconImgView);
        make.width.equalTo(@(190 * WIDTH_MULTIPLE));
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconImgView.mas_right).offset(6 * WIDTH_MULTIPLE);
        make.centerY.equalTo(_iconImgView);
        make.right.equalTo(_orderIDLabel.mas_left);
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconImgView);
        make.right.equalTo(_orderIDLabel);
        make.height.mas_equalTo(1);
        make.top.equalTo(self).offset(40 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.bottom.equalTo(self);
    }];
    
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(_topLine).offset(5 * WIDTH_MULTIPLE);
        make.width.height.mas_equalTo(70 * WIDTH_MULTIPLE);
    }];
    
    [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_itemImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_itemImgView);
        make.height.mas_equalTo(20);
        make.right.equalTo(self);
    }];
    
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_itemLabel.mas_bottom).offset(2 * WIDTH_MULTIPLE);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(250);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_itemImgView).offset(-4 * WIDTH_MULTIPLE);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    
    [_goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_itemImgView);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
        make.bottom.equalTo(_bottomLine);
        make.width.equalTo(@(180 * WIDTH_MULTIPLE));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_topLine);
        make.height.equalTo(@1);
        make.bottom.equalTo(_bottomLine.mas_top).offset(-38 * WIDTH_MULTIPLE);
    }];
    
    [_refundStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.height.bottom.equalTo(_goodsCountLabel);
        make.width.mas_equalTo(120);
    }];
}

#pragma mark - setter
- (void)setModel:(HYMySaleAfterListModel *)model{
    
    _model = model;
    _shopLabel.text = model.seller_name;
    _orderIDLabel.text = [NSString stringWithFormat:@"订单编号%@",model.sorder_id];
    _goodsCountLabel.text = [NSString stringWithFormat:@"共%@件商品",model.summary_qty];
    [_itemImgView sd_setImageWithURL:[NSURL URLWithString:model.refOrderdtls[0][@"item_url"]] placeholderImage:[UIImage imageNamed:@"order_placeholder"]];
    _itemLabel.text = model.refOrderdtls[0][@"item_name"];
    _unitLabel.text = model.refOrderdtls[0][@"unit"];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.refOrderdtls[0][@"price"]];
    
    NSString *str = [model.order_stat integerValue] == 1 ? @"售后处理中" : [model.order_stat integerValue] == 2 ? @"商家同意退款" : [model.order_stat integerValue] == 3 ? @"买家发货" : [model.order_stat integerValue] == 8 ? @"卖家发货"  : [model.order_stat integerValue] == 9 ? @"订单关闭" : [model.order_stat integerValue] == 10 ? @"订单入账" :@"售后处理中";
    _refundStateLabel.text = str;
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shop"]];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UILabel *)shopLabel{
    
    if (!_shopLabel) {
        
        _shopLabel = [[UILabel alloc] init];
        _shopLabel.font = KFitFont(13);
        _shopLabel.textAlignment = NSTextAlignmentLeft;
        _shopLabel.text = @"海林官方旗舰店";
        _shopLabel.textColor = KAPP_272727_COLOR;
        
    }
    return _shopLabel;
}

- (UILabel *)orderIDLabel{
    
    if (!_orderIDLabel) {
        
        _orderIDLabel = [[UILabel alloc] init];
        _orderIDLabel.font = KFitFont(11);
        _orderIDLabel.textAlignment = NSTextAlignmentRight;
        _orderIDLabel.text = @"海林官方旗舰店";
        _orderIDLabel.adjustsFontSizeToFitWidth = YES;
        _orderIDLabel.textColor = KAPP_272727_COLOR;
    }
    return _orderIDLabel;
}

- (UILabel *)goodsCountLabel{
    
    if (!_goodsCountLabel) {
        
        _goodsCountLabel = [[UILabel alloc] init];
        _goodsCountLabel.font = KFitFont(14);
        _goodsCountLabel.textAlignment = NSTextAlignmentLeft;
        _goodsCountLabel.text = @"海林官方旗舰店";
        _goodsCountLabel.textColor = KAPP_272727_COLOR;
    }
    return _goodsCountLabel;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = KAPP_SEPERATOR_COLOR;
        
        _middleLine = [[UIView alloc] init];
        _middleLine.backgroundColor = KAPP_SEPERATOR_COLOR;
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (UIImageView *)itemImgView{
    
    if (!_itemImgView) {
        
        _itemImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _itemImgView.contentMode = UIViewContentModeScaleAspectFill;
        _itemImgView.clipsToBounds = YES;
        _itemImgView.image = [UIImage imageNamed:@"order_placeholder"];
    }
    
    return _itemImgView;
}

- (UILabel *)itemLabel{
    
    if (!_itemLabel) {
        
        _itemLabel = [UILabel new];
        _itemLabel.text = @"来自老挝的天然健康产品";
        _itemLabel.textColor = KAPP_272727_COLOR;
        _itemLabel.font = KFitFont(14);
        _itemLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _itemLabel;
}

- (UILabel *)unitLabel{
    
    if (!_unitLabel) {
        
        _unitLabel = [UILabel new];
        _unitLabel.text = @"100g";
        _unitLabel.textColor = KAPP_b7b7b7_COLOR;
        _unitLabel.font = KFitFont(12);
        _unitLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _unitLabel;
}



- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KFitFont(14);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"实付 ￥0.00";
        _priceLabel.textColor = KAPP_PRICE_COLOR;
    }
    return _priceLabel;
}

- (UILabel *)refundStateLabel{
    
    if (!_refundStateLabel) {
        
        _refundStateLabel = [[UILabel alloc] init];
        _refundStateLabel.font = KFitFont(14);
        _refundStateLabel.textAlignment = NSTextAlignmentRight;
        _refundStateLabel.text = @"申请退款中";
        _refundStateLabel.textColor = KAPP_PRICE_COLOR;
    }
    return _refundStateLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

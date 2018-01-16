//
//  HYGoodsPayTableViewCell.m
//  DaCongMing
//
//

#import "HYGoodsPayTableViewCell.h"

@interface HYGoodsPayTableViewCell()

/** 商品总计 */
@property (nonatomic,strong) UILabel *goodsTotalLabel;
/** 商品总价格 */
@property (nonatomic,strong) UILabel *totalPriceLabel;
/** 支付宝 */
@property (nonatomic,strong) UIImageView *alipayImgView;
/** 支付宝 */
@property (nonatomic,strong) UILabel *alipayLabel;
/** 微信 */
@property (nonatomic,strong) UILabel *WeChatLabel;
/** 微信 */
@property (nonatomic,strong) UIImageView *weChatImgView;
/** 支付宝选择 */
@property (nonatomic,strong) UIButton *alipaySelectBtn;
/** 微信选择 */
@property (nonatomic,strong) UIButton *wechatBtnSelectBtn;
/** payLine */
@property (nonatomic,strong) UIView *payLine;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

/** 记录上一次点击的btn */
@property (nonatomic,strong) UIButton *previousSelectBtn;

@end

@implementation HYGoodsPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
        self.previousSelectBtn = _alipaySelectBtn;
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.goodsTotalLabel];
    [self addSubview:self.totalPriceLabel];
    [self addSubview:self.alipayLabel];
    [self addSubview:self.alipayImgView];
    [self addSubview:self.weChatImgView];
    [self addSubview:self.WeChatLabel];
    [self addSubview:self.alipaySelectBtn];
    [self addSubview:self.wechatBtnSelectBtn];
    [self addSubview:self.payLine];
    [self addSubview:self.bottomLine];
}

#pragma mark - setter
- (void)setOrderModel:(HYCreateOrder *)orderModel{
    
    _orderModel = orderModel;
    _totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",orderModel.summary_price];
}

#pragma mark - action
- (void)payButtonAction:(UIButton *)button{
    
    _previousSelectBtn.selected = NO;
    button.selected = YES;
    _previousSelectBtn = button;
    
    if (self.orderPayModeBlock) {
        
        self.orderPayModeBlock(button.tag - 100);
    }
}

- (void)layoutSubviews{
    
    [_goodsTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self);
        make.height.equalTo(@(45 * WIDTH_MULTIPLE));
        make.width.equalTo(@(120));
    }];
    
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.top.height.equalTo(_goodsTotalLabel);
        make.width.equalTo(@(120));
    }];
    
    [_alipayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_goodsTotalLabel.mas_bottom).offset(6 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@(32 * WIDTH_MULTIPLE));
        make.left.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_alipayImgView.mas_right).offset(15 * WIDTH_MULTIPLE);
        make.width.equalTo(@140);
        make.top.height.equalTo(_alipayImgView);
    }];
    
    [_payLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(_alipayImgView.mas_bottom).offset(12 * WIDTH_MULTIPLE);
    }];
    
    [_weChatImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_alipayImgView);
        make.top.equalTo(_payLine.mas_bottom).offset(6 * WIDTH_MULTIPLE);
    }];
    
    [_WeChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.height.width.equalTo(_alipayLabel);
        make.top.equalTo(_weChatImgView);
    }];
    
    [_alipaySelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.top.equalTo(_alipayImgView);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
    }];
    
    [_wechatBtnSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.top.equalTo(_weChatImgView);
        make.right.equalTo(_alipaySelectBtn);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

#pragma mark - lazyload
- (UILabel *)goodsTotalLabel{
    
    if (!_goodsTotalLabel) {
        
        _goodsTotalLabel = [[UILabel alloc] init];
        _goodsTotalLabel.font = KFitFont(15);
        _goodsTotalLabel.textAlignment = NSTextAlignmentLeft;
        _goodsTotalLabel.text = @"商品合计";
        _goodsTotalLabel.textColor = KAPP_272727_COLOR;
    }
    return _goodsTotalLabel;
}

- (UILabel *)totalPriceLabel{
    
    if (!_totalPriceLabel) {
        
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.font = KFitFont(15);
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
        _totalPriceLabel.text = @"￥0.00";
        _totalPriceLabel.textColor = KAPP_272727_COLOR;
    }
    return _totalPriceLabel;
}

- (UIImageView *)alipayImgView{
    
    if (!_alipayImgView) {
        
        _alipayImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_alipay"]];
        _alipayImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _alipayImgView;
}

- (UILabel *)alipayLabel{
    
    if (!_alipayLabel) {
        
        _alipayLabel = [[UILabel alloc] init];
        _alipayLabel.font = KFitFont(14);
        _alipayLabel.textAlignment = NSTextAlignmentLeft;
        _alipayLabel.text = @"支付宝支付";
        _alipayLabel.textColor = KAPP_272727_COLOR;
        _alipayLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            UIButton *button = [self viewWithTag:100];
            [self payButtonAction:button];
        }];
        [_alipayLabel addGestureRecognizer:tap];
    }
    return _alipayLabel;
}

- (UIImageView *)weChatImgView{
    
    if (!_weChatImgView) {
        
        _weChatImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_weChat"]];
        _weChatImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _weChatImgView;
}

- (UILabel *)WeChatLabel{
    
    if (!_WeChatLabel) {
        
        _WeChatLabel = [[UILabel alloc] init];
        _WeChatLabel.font = KFitFont(14);
        _WeChatLabel.textAlignment = NSTextAlignmentLeft;
        _WeChatLabel.text = @"微信支付";
        _WeChatLabel.textColor = KAPP_272727_COLOR;
        _WeChatLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            UIButton *button = [self viewWithTag:101];
            [self payButtonAction:button];
        }];
        [_WeChatLabel addGestureRecognizer:tap];
    }
    return _WeChatLabel;
}

- (UIButton *)alipaySelectBtn{
    
    if (!_alipaySelectBtn) {
        
        _alipaySelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alipaySelectBtn setImage:[UIImage imageNamed:@"order_pay"] forState:UIControlStateNormal];
        [_alipaySelectBtn setImage:[UIImage imageNamed:@"order_pay_select"] forState:UIControlStateSelected];
        _alipaySelectBtn.selected = YES;
        _alipaySelectBtn.tag = 100;
        [_alipaySelectBtn addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alipaySelectBtn;
}

- (UIButton *)wechatBtnSelectBtn{
    
    if (!_wechatBtnSelectBtn) {
        
        _wechatBtnSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatBtnSelectBtn setImage:[UIImage imageNamed:@"order_pay"] forState:UIControlStateNormal];
        [_wechatBtnSelectBtn setImage:[UIImage imageNamed:@"order_pay_select"] forState:UIControlStateSelected];
        [_wechatBtnSelectBtn addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _wechatBtnSelectBtn.tag = 101;
    }
    return _wechatBtnSelectBtn;
}

- (UIView *)payLine{
    
    if (!_payLine) {
        
        _payLine = [[UIView alloc] init];
        _payLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _payLine;
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

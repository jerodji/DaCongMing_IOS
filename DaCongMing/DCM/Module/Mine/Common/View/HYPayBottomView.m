//
//  HYPayBottomView.m
//  DaCongMing
//
//

#import "HYPayBottomView.h"

@interface HYPayBottomView()

/** 待支付 */
@property (nonatomic,strong) UILabel *payMoneyLabel;


@property (nonatomic,strong) UIView *topLine;

@end

@implementation HYPayBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        self.backgroundColor = KAPP_WHITE_COLOR;
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.topLine];
    [self addSubview:self.payMoneyLabel];
    [self addSubview:self.payBtn];
}

- (void)layoutSubviews{
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(5);
//        make.bottom.equalTo(self).offset(-5);
        make.height.mas_equalTo(40*WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10);
        make.width.mas_equalTo(105 * WIDTH_MULTIPLE);
    }];
    
    [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        make.right.equalTo(_payBtn.mas_left).offset(-30 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_payBtn);
        make.left.equalTo(self);
    }];
}

- (void)payBtnAction{
    
    if (self.payBlock) {
        
        self.payBlock();
    }
}

- (void)setPayAmount:(NSString *)payAmount{
    
    _payAmount = payAmount;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待支付:￥%@",payAmount]];
    [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(13),NSForegroundColorAttributeName : KAPP_272727_COLOR} range:NSMakeRange(0, attributeStr.length)];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_PRICE_COLOR} range:NSMakeRange(4, attributeStr.length - 4)];
    _payMoneyLabel.attributedText = attributeStr;
}

#pragma mark - payMoneyLabel
- (UILabel *)payMoneyLabel{
    
    if (!_payMoneyLabel) {
        
        _payMoneyLabel = [[UILabel alloc] init];
        _payMoneyLabel.font = KFitFont(13);
        _payMoneyLabel.textColor = KAPP_b7b7b7_COLOR;
        _payMoneyLabel.text = @"待支付:￥998";
        _payMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _payMoneyLabel;
}

- (UIView *)topLine{
    
    if (!_topLine) {
        
        _topLine = [UIView new];
        _topLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _topLine;
}

- (UIButton *)payBtn{
    
    if (!_payBtn) {
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.backgroundColor = UIColorRGB(56, 173, 152);// KAPP_THEME_COLOR;
        [_payBtn setTitle:@"支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _payBtn.titleLabel.font = KFitFont(15);
        _payBtn.layer.cornerRadius = 5;
        [_payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

@end

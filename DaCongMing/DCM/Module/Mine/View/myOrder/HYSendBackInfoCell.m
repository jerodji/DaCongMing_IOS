//
//  HYSendBackInfoCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSendBackInfoCell.h"

@interface HYSendBackInfoCell() <UITextFieldDelegate>

/** 垂直线 */
@property (nonatomic,strong) UIView *verticalLine;
/** 白色背景 */
@property (nonatomic,strong) UIView *whiteBgView;
/** 小点 */
@property (nonatomic,strong) UIImageView *dotImgView;
/** 申请时间 */
@property (nonatomic,strong) UILabel *createTimeLabel;
/** 收货地址 */
@property (nonatomic,strong) UILabel *addressLabel;
/** 邮编 */
@property (nonatomic,strong) UILabel *postLabel;
/** 电话 */
@property (nonatomic,strong) UILabel *phoneLabel;
/** receiver */
@property (nonatomic,strong) UILabel *receiverLabel;
/** 物流公司 */
@property (nonatomic,strong) UITextField *logisticsCompanyTF;
/** 物流单号 */
@property (nonatomic,strong) UITextField *logisticsNumerTF;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYSendBackInfoCell

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
    
    [self addSubview:self.verticalLine];
    [self addSubview:self.whiteBgView];
    [self addSubview:self.dotImgView];
    [self addSubview:self.createTimeLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.postLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.receiverLabel];
    [self addSubview:self.logisticsCompanyTF];
    [self addSubview:self.logisticsNumerTF];
    [self addSubview:self.confirmBtn];
}

- (void)layoutSubviews{
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(1);
    }];
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(41 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self);
    }];
    
    [_dotImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_verticalLine);
        make.top.equalTo(_whiteBgView).offset(15 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(11 * WIDTH_MULTIPLE, 11 * WIDTH_MULTIPLE));
    }];
    
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteBgView);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
        make.left.equalTo(_whiteBgView).offset(5);
        make.right.equalTo(_whiteBgView).offset(-5);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_createTimeLabel);
        make.top.equalTo(_createTimeLabel.mas_bottom);
        make.height.mas_equalTo(45 * WIDTH_MULTIPLE);
    }];
    
    CGFloat width = [@"邮编:121121" widthForFont:KFitFont(14)];
    [_postLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_createTimeLabel);
        make.width.mas_equalTo(width + 15);
        make.top.equalTo(_addressLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    CGFloat phoneWidth = [KCustomerServicePhone widthForFont:KFitFont(12)];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(_postLabel);
        make.width.mas_equalTo(phoneWidth + 50);
        make.left.equalTo(_postLabel.mas_right);
    }];
    
    [_receiverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.height.equalTo(_postLabel);
        make.top.equalTo(_postLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
    }];
    
    [_logisticsCompanyTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_postLabel);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
        make.top.equalTo(_receiverLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(200 * WIDTH_MULTIPLE);
    }];
    
    [_logisticsNumerTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.height.equalTo(_logisticsCompanyTF);
        make.top.equalTo(_logisticsCompanyTF.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(200 * WIDTH_MULTIPLE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_logisticsCompanyTF);
        make.top.equalTo(_logisticsNumerTF.mas_bottom).offset(15 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);

    }];
}

#pragma mark - action
- (void)textChanged:(UITextField *)textField{
    
    if ([self.logisticsCompanyTF.text isNotBlank] && [self.logisticsNumerTF.text isNotBlank]) {
        
        [self.confirmBtn setBackgroundColor:KAPP_THEME_COLOR];
        [self.confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        self.confirmBtn.userInteractionEnabled = YES;
    }
    else{
        
        [self.confirmBtn setBackgroundColor:KAPP_TableView_BgColor];
        [self.confirmBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        self.confirmBtn.userInteractionEnabled = NO;

    }
}

- (void)comfirmBtnAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(submitLogisticWithCompany:andNumber:)]) {
        
        [_delegate submitLogisticWithCompany:self.logisticsCompanyTF.text andNumber:self.logisticsNumerTF.text];
    }
}

#pragma mark - setter
- (void)setModel:(HYRefundModel *)model{
    
    _model = model;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"商家已受理，请把要退的货邮寄到:%@",model.ref_address]];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_TextSpecial_COLOR} range:NSMakeRange(attributeStr.length - model.ref_address.length, model.ref_address.length)];
    _addressLabel.attributedText = attributeStr;
    
    NSMutableAttributedString *postAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"邮编:%@",model.ref_postcode]];
    [postAttributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_TextSpecial_COLOR} range:NSMakeRange(postAttributeStr.length - model.ref_postcode.length, model.ref_postcode.length)];
    _postLabel.attributedText = postAttributeStr;
    
    NSMutableAttributedString *phoneAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"电话:%@",model.ref_phone]];
    [phoneAttributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_TextSpecial_COLOR} range:NSMakeRange(phoneAttributeStr.length - model.ref_phone.length, model.ref_phone.length)];
    _phoneLabel.attributedText = phoneAttributeStr;
    
    NSMutableAttributedString *receiverAttributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"收货人:%@",model.ref_receiver]];
    [receiverAttributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_TextSpecial_COLOR} range:NSMakeRange(receiverAttributeStr.length - model.ref_receiver.length, model.ref_receiver.length)];
    _receiverLabel.attributedText = receiverAttributeStr;
    
    if ([model.order_stat integerValue] != 2) {
        
        self.logisticsCompanyTF.hidden = YES;
        self.logisticsNumerTF.hidden = YES;
        self.confirmBtn.hidden = YES;
    }
    else{
        
        self.logisticsCompanyTF.hidden = NO;
        self.logisticsNumerTF.hidden = NO;
        self.confirmBtn.hidden = NO;
    }
}



#pragma mark - lazyload
- (UIView *)verticalLine{
    
    if (!_verticalLine) {
        
        _verticalLine = [UIView new];
        _verticalLine.backgroundColor = KCOLOR(@"dddddd");
    }
    return _verticalLine;
}

- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
        _whiteBgView.layer.cornerRadius = 6 * WIDTH_MULTIPLE;
        _whiteBgView.layer.masksToBounds = YES;
    }
    return _whiteBgView;
}

- (UIImageView *)dotImgView{
    
    if (!_dotImgView) {
        
        _dotImgView = [UIImageView new];
        _dotImgView.image = [UIImage imageNamed:@"dot"];
    }
    return _dotImgView;
}

- (UILabel *)createTimeLabel{
    
    if (!_createTimeLabel) {
        
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.font = KFitFont(12);
        _createTimeLabel.textAlignment = NSTextAlignmentLeft;
        _createTimeLabel.text = @"2017.10.12";
        _createTimeLabel.textColor = KAPP_272727_COLOR;
    }
    return _createTimeLabel;
}

- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = KFitFont(14);
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.text = @"商家已受理，请把要退的货邮寄到:";
        _addressLabel.textColor = KAPP_272727_COLOR;
        _addressLabel.numberOfLines = 0;
    }
    return _addressLabel;
}

- (UILabel *)postLabel{
    
    if (!_postLabel) {
        
        _postLabel = [[UILabel alloc] init];
        _postLabel.font = KFitFont(14);
        _postLabel.textAlignment = NSTextAlignmentLeft;
        _postLabel.text = @"邮编:";
        _postLabel.textColor = KAPP_272727_COLOR;
    }
    return _postLabel;
}


- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = KFitFont(14);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.text = @"电话:";
        _phoneLabel.textColor = KAPP_272727_COLOR;
        _phoneLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            NSString * str = [[NSString alloc] initWithFormat:@"tel://%@",_model.ref_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        [_phoneLabel addGestureRecognizer:tapGes];
    }
    return _phoneLabel;
}

- (UILabel *)receiverLabel{
    
    if (!_receiverLabel) {
        
        _receiverLabel = [[UILabel alloc] init];
        _receiverLabel.font = KFitFont(14);
        _receiverLabel.textAlignment = NSTextAlignmentLeft;
        _receiverLabel.text = @"收货人:";
        _receiverLabel.textColor = KAPP_272727_COLOR;
    }
    return _receiverLabel;
}

- (UITextField *)logisticsCompanyTF{
    
    if (!_logisticsCompanyTF) {
        
        _logisticsCompanyTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _logisticsCompanyTF.delegate = self;
        _logisticsCompanyTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"  请填写物流公司" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(12)}];
        _logisticsCompanyTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _logisticsCompanyTF.font = KFitFont(12);
        _logisticsCompanyTF.textAlignment = NSTextAlignmentLeft;
        _logisticsCompanyTF.keyboardType = UIKeyboardTypeDefault;
        _logisticsCompanyTF.layer.cornerRadius = 2;
        _logisticsCompanyTF.layer.borderColor = KAPP_SEPERATOR_COLOR.CGColor;
        _logisticsCompanyTF.layer.borderWidth = 1;
        [_logisticsCompanyTF setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
        _logisticsCompanyTF.backgroundColor = KCOLOR(@"f6f6f6");
        _logisticsCompanyTF.textColor = KAPP_272727_COLOR;
        [_logisticsCompanyTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _logisticsCompanyTF;
}

- (UITextField *)logisticsNumerTF{
    
    if (!_logisticsNumerTF) {
        
        _logisticsNumerTF = [[UITextField alloc] initWithFrame:CGRectZero];
        _logisticsNumerTF.delegate = self;
        _logisticsNumerTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"  请填写物流单号" attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(12)}];
        _logisticsNumerTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _logisticsNumerTF.font = KFitFont(12);
        _logisticsNumerTF.textAlignment = NSTextAlignmentLeft;
        _logisticsNumerTF.keyboardType = UIKeyboardTypePhonePad;
        _logisticsNumerTF.layer.cornerRadius = 2;
        _logisticsNumerTF.layer.borderColor = KAPP_SEPERATOR_COLOR.CGColor;
        _logisticsNumerTF.layer.borderWidth = 1;
        _logisticsNumerTF.backgroundColor = KCOLOR(@"f6f6f6");
        [_logisticsNumerTF setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
        _logisticsNumerTF.textColor = KAPP_272727_COLOR;
        [_logisticsNumerTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _logisticsNumerTF;
}


- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KAPP_TableView_BgColor;
        [_confirmBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(16);
        _confirmBtn.layer.cornerRadius = 2;
        _confirmBtn.clipsToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(comfirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

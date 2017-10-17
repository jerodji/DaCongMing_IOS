//
//  HYFillSalesReturnCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYFillSalesReturnCell.h"

@interface HYFillSalesReturnCell() <UITextFieldDelegate,UITextViewDelegate>

/** bgView */
@property (nonatomic,strong) UIView *bgView;
/** 退款数量 */
@property (nonatomic,strong) UITextField *salesReturnCountTextField;
/** countLabel */
@property (nonatomic,strong) UILabel *countLabel;
/** 退款金额 */
@property (nonatomic,strong) UILabel *amoutLabel;
/** 退款原因 */
@property (nonatomic,strong) SAMTextView *reasonTextView;

@end

@implementation HYFillSalesReturnCell

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
    [self addSubview:self.salesReturnCountTextField];
    [self addSubview:self.countLabel];
    [self addSubview:self.amoutLabel];
    [self addSubview:self.reasonTextView];
    
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_salesReturnCountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(30 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50 * WIDTH_MULTIPLE);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.equalTo(_salesReturnCountTextField);
        make.width.mas_equalTo(self.width / 2);
    }];
    
    [_amoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_salesReturnCountTextField);
        make.top.equalTo(_salesReturnCountTextField.mas_bottom);
        make.height.mas_equalTo(45 * WIDTH_MULTIPLE);
    }];
    
    [_reasonTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(_salesReturnCountTextField);
        make.top.equalTo(_amoutLabel.mas_bottom);
        make.height.mas_equalTo(150 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - textViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (_delegate && [_delegate respondsToSelector:@selector(fillSalesReturnInoInput:andReason:)]) {
        
        [_delegate fillSalesReturnInoInput:self.salesReturnCountTextField.text andReason:textView.text];
    }
}

- (void)textChanged:(UITextView *)textField{
    
    if (_delegate && [_delegate respondsToSelector:@selector(fillSalesReturnInoInput:andReason:)]) {
        
        [_delegate fillSalesReturnInoInput:self.salesReturnCountTextField.text andReason:self.reasonTextView.text];
    }
}

#pragma mark - lazyload
- (UITextField *)salesReturnCountTextField{
    
    if (!_salesReturnCountTextField) {
        
        _salesReturnCountTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _salesReturnCountTextField.delegate = self;
        _salesReturnCountTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"最多两件" attributes:@{NSForegroundColorAttributeName:KAPP_b7b7b7_COLOR,NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        _salesReturnCountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _salesReturnCountTextField.font = [UIFont systemFontOfSize:14];
        _salesReturnCountTextField.textAlignment = NSTextAlignmentRight;
        _salesReturnCountTextField.keyboardType = UIKeyboardTypePhonePad;
        _salesReturnCountTextField.layer.cornerRadius = 5;
        _salesReturnCountTextField.layer.borderColor = KAPP_SEPERATOR_COLOR.CGColor;
        _salesReturnCountTextField.layer.borderWidth = 1;
        [_salesReturnCountTextField setValue:[NSNumber numberWithInt:10] forKey:@"paddingRight"];
        [_salesReturnCountTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _salesReturnCountTextField;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UILabel *)amoutLabel{
    
    if (!_amoutLabel) {
        
        _amoutLabel = [[UILabel alloc] init];
        _amoutLabel.font = KFitFont(14);
        _amoutLabel.textAlignment = NSTextAlignmentRight;
        _amoutLabel.text = @"退款金额:0.00";
        _amoutLabel.textColor = KAPP_PRICE_COLOR;
    }
    return _amoutLabel;
}

- (UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = KFitFont(14);
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.text = @"   输入退款商品的数量";
        _countLabel.textColor = KAPP_272727_COLOR;
    }
    return _countLabel;
}

- (SAMTextView *)reasonTextView{
    
    if (!_reasonTextView) {
        
        _reasonTextView = [[SAMTextView alloc] init];
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@" 输入退款原因，10-100个字，以便客服尽快为你处理" attributes:@{NSForegroundColorAttributeName : KAPP_b7b7b7_COLOR,NSFontAttributeName : [UIFont systemFontOfSize:16]}];
        _reasonTextView.attributedPlaceholder = attributeStr;
        _reasonTextView.font = KFitFont(16);
        _reasonTextView.textColor = KAPP_272727_COLOR;
        _reasonTextView.delegate = self;
        _reasonTextView.backgroundColor = KAPP_WHITE_COLOR;
        _reasonTextView.layer.cornerRadius = 5;
        _reasonTextView.layer.borderColor = KAPP_SEPERATOR_COLOR.CGColor;
        _reasonTextView.layer.borderWidth = 1;
    }
    return _reasonTextView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

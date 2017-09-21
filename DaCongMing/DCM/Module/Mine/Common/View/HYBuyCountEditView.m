//
//  HYBuyCountEditView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBuyCountEditView.h"

@interface HYBuyCountEditView() <UITextFieldDelegate>

/** 减 */
@property (nonatomic,strong) UIButton *minusBtn;
/** 加 */
@property (nonatomic,strong) UIButton *addBtn;
/** textField */
@property (nonatomic,strong) UITextField *numberTextField;

@end


@implementation HYBuyCountEditView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.minusBtn];
    [self addSubview:self.numberTextField];
    [self addSubview:self.addBtn];
}

- (void)layoutSubviews{
    
    [_minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(_minusBtn);
    }];
    
    [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.left.equalTo(_minusBtn.mas_right);
        make.right.equalTo(_addBtn.mas_left);
    }];
}

#pragma mark - action
- (void)minusAction{
    
    if ([_numberTextField isFirstResponder])
    {
        [_numberTextField resignFirstResponder];
    }
    
    NSInteger currentNumber = [_numberTextField.text integerValue];
    if (currentNumber > 1) {
        
        currentNumber--;
    }
    else{
        currentNumber = 1;
    }
    
    NSString *numStr = @(currentNumber).description;
    _numberTextField.text = numStr;
    
    if (self.countCallback) {
        self.countCallback(currentNumber);
    }
}

- (void)addAction{
    
    if ([_numberTextField isFirstResponder])
    {
        [_numberTextField resignFirstResponder];
    }
    
    NSInteger currentNumber = [_numberTextField.text integerValue];
    currentNumber ++;
    NSString *numStr = @(currentNumber).description;
    _numberTextField.text = numStr;
    
    if (self.countCallback) {
        self.countCallback(currentNumber);
    }
}

- (void)numberEditChanged:(UITextField *)sender{
    
    //限制首位不能输0
    NSString *numberText = sender.text;

    for (int i = 0; i < numberText.length; i++)
    {
        NSString *subText = [numberText substringWithRange:NSMakeRange(i, 1)];
        // 首个输入不能为0
        if (i == 0 && subText.integerValue == 0)
        {
            numberText = [numberText stringByReplacingOccurrencesOfString:subText withString:@"1"];
        }
        
    }
    
    if (self.countCallback) {
        
        self.countCallback([numberText integerValue]);
    }
    _numberTextField.text = numberText;
}

#pragma mark - lazyload
- (UIButton *)minusBtn{
    
    if (!_minusBtn) {
        
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _minusBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_minusBtn setImage:[UIImage imageNamed:@"number_minus"] forState:UIControlStateNormal];
        [_minusBtn addTarget:self action:@selector(minusAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}

- (UITextField *)numberTextField{
    
    if (!_numberTextField) {
        
        _numberTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _numberTextField.delegate = self;
        _numberTextField.text = @"1";
        _numberTextField.font = KFitFont(16);
        _numberTextField.textColor = KCOLOR(@"272727");
        _numberTextField.textAlignment = NSTextAlignmentCenter;
        _numberTextField.keyboardType = UIKeyboardTypePhonePad;
        [_numberTextField addTarget:self action:@selector(numberEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _numberTextField;
}

- (UIButton *)addBtn{
    
    if (!_addBtn) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_addBtn setImage:[UIImage imageNamed:@"number_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end

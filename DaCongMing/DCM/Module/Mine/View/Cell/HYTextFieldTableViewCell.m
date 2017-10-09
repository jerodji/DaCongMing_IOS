//
//  HYTextFieldTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYTextFieldTableViewCell.h"

@interface HYTextFieldTableViewCell() <UITextFieldDelegate>

/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;

/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYTextFieldTableViewCell

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
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self addSubview:self.bottomLine];
    
}

- (void)layoutSubviews{
    
    CGFloat width = [_title widthForFont:KFitFont(14)] + 20;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@(width));
    }];
    
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_titleLabel);
        make.right.equalTo(self).offset(50 * WIDTH_MULTIPLE);
        make.left.equalTo(_titleLabel.mas_right);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

#pragma mark - action
- (void)textFieldInputChange:(UITextField *)textField{
    
   
    
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldCellInput:)]) {
        
        [_delegate textFieldCellInput:self];
    }
    
    
}


#pragma mark - setter
- (void)setTitle:(NSString *)title{
    
    _title = title;
    _titleLabel.text = title;
    
      NSString *str = [NSString stringWithFormat:@"请填写%@",title];
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName:KAPP_7b7b7b_COLOR,NSFontAttributeName : KFitFont(14)}];
}


#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"用户名";
        _titleLabel.textColor = KAPP_272727_COLOR;
    }
    return _titleLabel;
}

- (UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = KFitFont(14);
        _textField.textColor = KAPP_7b7b7b_COLOR;
        _textField.keyboardType = UIKeyboardTypeDefault;
        [_textField addTarget:self action:@selector(textFieldInputChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
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

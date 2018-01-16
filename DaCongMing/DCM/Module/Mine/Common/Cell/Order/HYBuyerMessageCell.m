//
//  HYBuyerMessageCell.m
//  DaCongMing
//
//

#import "HYBuyerMessageCell.h"

@implementation HYBuyerMessageCell


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
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(80 * WIDTH_MULTIPLE);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_titleLabel);
        make.right.equalTo(self).offset(50 * WIDTH_MULTIPLE);
        make.left.equalTo(_titleLabel.mas_right).offset(2 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    
}

#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(15);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"买家留言:";
        _titleLabel.textColor = KAPP_272727_COLOR;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
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
        _textField.placeholder = @"对本次交易的说明";
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

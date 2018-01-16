//
//  HYProductsInfoTableViewCell.m
//  DaCongMing
//
//

#import "HYProductsInfoTableViewCell.h"

@interface HYProductsInfoTableViewCell()

/** price */
@property (nonatomic,strong) UILabel *priceLabel;
/** note */
@property (nonatomic,strong) UILabel *noteLabel;

@end

@implementation HYProductsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.priceLabel];
        [self addSubview:self.noteLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_priceLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-5 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - setter
- (void)setPrice:(NSString *)price{
    
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price] attributes:@{NSForegroundColorAttributeName : KAPP_PRICE_COLOR, NSFontAttributeName : KFitFont(18)}];
    [priceStr addAttributes:@{NSFontAttributeName : KFitFont(16)} range:NSMakeRange(0, 1)];
    _priceLabel.attributedText = priceStr ;
}

- (void)setNote:(NSString *)note{
    
    _note = note;
    _noteLabel.text = note;
}

#pragma mark - lazyload
- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KFitFont(18);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.text = @"老挝海林";
    }
    return _priceLabel;
}

- (UILabel *)noteLabel{
    
    if (!_noteLabel) {
        
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.font = KFitFont(13);
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.textColor = KCOLOR(@"7b7b7b");
        _noteLabel.text = @"老挝海林";
        _noteLabel.numberOfLines = 0;
    }
    return _noteLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

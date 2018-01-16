//
//  HYRecommendPayItemCell.m
//  DaCongMing
//
//

#import "HYRecommendPayItemCell.h"

@interface HYRecommendPayItemCell()

/** 待支付 */
@property (nonatomic,strong) UILabel *payLabel;

@end

@implementation HYRecommendPayItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.payLabel];
        [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.bottom.right.equalTo(self);
            make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        }];
    }
    return self;
}

#pragma mark - lazyload
- (UILabel *)payLabel{
    
    if (!_payLabel) {
        
        _payLabel = [UILabel new];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"待支付1项" attributes:@{NSFontAttributeName : KFitFont(13), NSForegroundColorAttributeName : KAPP_272727_COLOR}];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:KAPP_PRICE_COLOR range:NSMakeRange(3, 1)];
        _payLabel.attributedText = attributeStr;
        _payLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _payLabel;
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

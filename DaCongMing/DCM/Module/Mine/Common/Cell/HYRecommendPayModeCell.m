//
//  HYRecommendPayModeCell.m
//  DaCongMing
//
//

#import "HYRecommendPayModeCell.h"

@interface HYRecommendPayModeCell ()

/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;
/** 文本标题 */
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYRecommendPayModeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.selectBtn];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25 * WIDTH_MULTIPLE, 25 * WIDTH_MULTIPLE));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90 * WIDTH_MULTIPLE, 25 * WIDTH_MULTIPLE));
    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(25 * WIDTH_MULTIPLE, 25 * WIDTH_MULTIPLE));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)setIConImage:(NSString *)icon andTitle:(NSString *)title{
    
    _iconImgView.image = [UIImage imageNamed:icon];
    _titleLabel.text = title;
}

#pragma mark - lazyload
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        _iconImgView.image = [UIImage imageNamed:@"order_alipay"];
    }
    return _iconImgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(13);
        _titleLabel.textColor = KCOLOR(@"272727");
        _titleLabel.text = @"支付宝";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"order_pay"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"order_pay_select"] forState:UIControlStateSelected];
        
    }
    return _selectBtn;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
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

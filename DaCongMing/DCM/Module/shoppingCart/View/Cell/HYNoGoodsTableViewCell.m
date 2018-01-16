//
//  HYNoGoodsTableViewCell.m
//  DaCongMing
//
//

#import "HYNoGoodsTableViewCell.h"

@interface HYNoGoodsTableViewCell()

/** shoppingCarts */
@property (nonatomic,strong) UIImageView *cartsImgView;
/** title */
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation HYNoGoodsTableViewCell

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
    
    self.backgroundColor = KCOLOR(@"f6f6f6");
    [self addSubview:self.cartsImgView];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews{
    
    [_cartsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(50 * WIDTH_MULTIPLE);
        make.height.equalTo(@(100 * WIDTH_MULTIPLE));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self.cartsImgView.mas_bottom).offset(26 * WIDTH_MULTIPLE);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - lazyload
- (UIImageView *)cartsImgView{
    
    if (!_cartsImgView) {
        
        _cartsImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopingCarts"]];
        _cartsImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _cartsImgView;
}

- (UILabel *)titleLabel{
    
        
    if (!_titleLabel) {
            
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(16);
        _titleLabel.textColor = KCOLOR(@"7b7b7b");
        _titleLabel.text = @"购物车暂无商品";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

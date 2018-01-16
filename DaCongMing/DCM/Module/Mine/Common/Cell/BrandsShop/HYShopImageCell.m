//
//  HYShopImageCell.m
//  DaCongMing
//
//

#import "HYShopImageCell.h"

@interface HYShopImageCell()

/** 图 */
@property (nonatomic,strong) UIImageView *bottomImageView;
/** 放心的购买 */
@property (nonatomic,strong) UILabel *assureBuyLabel;

@end

@implementation HYShopImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KCOLOR(@"f6f6f6");
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bottomImageView];
    [self addSubview:self.assureBuyLabel];
}

- (void)layoutSubviews{
    
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_assureBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.bottom.equalTo(_bottomImageView);
    }];
}

#pragma mark - lazyload
- (UIImageView *)bottomImageView{
    
    if (!_bottomImageView) {
        
        _bottomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"assureBuy"]];
        _bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bottomImageView.clipsToBounds = YES;
    }
    return _bottomImageView;
}

- (UILabel *)assureBuyLabel{
    
    if (!_assureBuyLabel) {
        
        _assureBuyLabel = [UILabel new];
        _assureBuyLabel.text = @"       放心的购买";
        _assureBuyLabel.textColor = KAPP_WHITE_COLOR;
        _assureBuyLabel.font = KFitFont(18);
        _assureBuyLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _assureBuyLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

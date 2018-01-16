//
//  HYBrandShopImageCell.m
//  DaCongMing
//
//

#import "HYBrandShopImageCell.h"

@interface HYBrandShopImageCell ()

@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation HYBrandShopImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.imgView];
        
    }
    return self;
}

- (void)layoutSubviews{

    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-5 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - setter
- (void)setModel:(HYBrandShopRecommendModel *)model{
    
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[UIImage imageNamed:@"forest"]];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.image = [UIImage imageNamed:@"forest"];
    }
    return _imgView;
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

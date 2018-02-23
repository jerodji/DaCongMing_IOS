//
//  HYTypeRecommendCollectionViewCell.m
//  DaCongMing
//
//

#import "HYTypeRecommendCollectionViewCell.h"

@interface HYTypeRecommendCollectionViewCell()

/** imgView */
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation HYTypeRecommendCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self);
        
    }];
}

- (void)setTypeItemModel:(HYTypeRecommendItemModel *)typeItemModel{

    _typeItemModel = typeItemModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:typeItemModel.image_url] placeholderImage:[UIImage imageNamed:ProductPlaceholder]];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        
    }
    return _imgView;
}

@end

//
//  HYHomeBannerCell.m
//  DaCongMing
//
//

#import "HYHomeBannerCell.h"

@implementation HYHomeBannerCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
}

- (void)setBannerModel:(HYHomeBannerModel *)bannerModel{
    
    _bannerModel = bannerModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:bannerModel.imgUrl]];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end

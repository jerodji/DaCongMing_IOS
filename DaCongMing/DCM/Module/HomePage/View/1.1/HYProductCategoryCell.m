//
//  HYProductCategoryCell.m
//  DaCongMing
//
//

#import "HYProductCategoryCell.h"

@implementation HYProductCategoryCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imgView];
        self.layer.cornerRadius = 5 * WIDTH_MULTIPLE;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.image = [UIImage imageNamed:@"dgal.jpg"];
    }
    return _imgView;
}

@end

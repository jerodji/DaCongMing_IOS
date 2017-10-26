//
//  HYHomeTagsCollectionViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeTagsCollectionViewCell.h"


@interface HYHomeTagsCollectionViewCell()

/** img */
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation HYHomeTagsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self);
    }];
}

- (void)setTagsItemModel:(HYTagsItemModel *)tagsItemModel{
    
    _tagsItemModel = tagsItemModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[tagsItemModel.image_url stringByURLDecode]] placeholderImage:[UIImage imageNamed:@"banner"]];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [UIImageView new];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    
    return _imgView;
}

@end

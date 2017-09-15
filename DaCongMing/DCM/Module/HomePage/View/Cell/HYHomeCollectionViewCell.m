//
//  HYHomeCollectionViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeCollectionViewCell.h"

@interface HYHomeCollectionViewCell()

/** img */
@property (nonatomic,strong) UIImageView *imgView;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 价格 */
@property (nonatomic,strong) UILabel *priceLabel;

@end

@implementation HYHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        
    }
    return self;
}

- (void)setCommendTodayModel:(HYReCommendTday *)commendTodayModel{

    [_imgView sd_setImageWithURL:[NSURL URLWithString:commendTodayModel.image_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _titleLabel.text = commendTodayModel.item_name;
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 130 * WIDTH_MULTIPLE)];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    
    return _imgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.bottom + 5, KSCREEN_WIDTH, 20)];
        _titleLabel.font = KFont(14);
        _titleLabel.textColor = KCOLOR(@"272727");
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;

}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.bottom + 5, KSCREEN_WIDTH, 20)];
        _priceLabel.font = KFont(14);
        _priceLabel.textColor = KCOLOR(@"7b7b7b");
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
    
}

@end

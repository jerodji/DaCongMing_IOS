//
//  HYHomeHeaderView.m
//  DaCongMing
//
//  Created by Jack on 2018/1/10.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import "HYHomeHeaderView.h"
#import <iCarousel.h>
#import "HYHomeBannerModel.h"

@interface HYHomeHeaderView () <iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong) iCarousel *bannerView;
@property (nonatomic,assign) CGFloat imageWidth;

@end



@implementation HYHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageWidth = KSCREEN_WIDTH * 5 / 6.0;
        [self addSubview:self.bannerView];

    }
    return self;
}

- (void)layoutSubviews{
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
}

- (void)setBannerModelArray:(NSArray *)bannerModelArray{
    
    _bannerModelArray =  bannerModelArray;
    [_bannerView reloadData];
}

#pragma mark - iCarouselDelegate
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    return self.bannerModelArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    if (!view) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.imageWidth, self.height)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor whiteColor];
        [view addSubview:imageView];
        
        view.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        view.layer.masksToBounds = YES;
        
        HYHomeBannerModel *model = self.bannerModelArray[index];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
        
    }
    return view;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    
    CGFloat scale = [self calculateScaleWithOffset:offset];
    CGFloat translation = [self calculateTranslationWithOffset:offset];
    CATransform3D transform3d = CATransform3DTranslate(transform, translation * self.width, 0, offset);
    return CATransform3DScale(transform3d, scale, scale, 0);
}

- (CGFloat)calculateScaleWithOffset:(CGFloat)offset{
    
    return offset * 0.04f + 1.0f;
}

//计算偏移量
- (CGFloat)calculateTranslationWithOffset:(CGFloat)offset{
    
    CGFloat z = 5.0f / 4.0f;
    CGFloat a = 5.0f / 8.0f;
    
    //移出屏幕
    if (offset >= z / a) {
        
        return 2.0f;
    }
    
    return 1 / (z - a * offset) - 1 / z;
}

#pragma mark - lazyload
- (iCarousel *)bannerView{
    
    if (!_bannerView) {
        
        _bannerView = [[iCarousel alloc] init];
        _bannerView.delegate = self;
        _bannerView.dataSource = self;
        _bannerView.type = iCarouselTypeRotary;
        _bannerView.bounceDistance = 0.2f;
    }
    return _bannerView;
}

@end

//
//  BannerView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "JJBannerView.h"

#import "HYBrandShopViewController.h"

@interface JJBannerView()<iCarouselDelegate, iCarouselDataSource>
//@property (nonatomic, assign) CGRect frameRect;
@end

@implementation JJBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
        //_frameRect = frame;
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)configCarousel {
    
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 219)];
    self.carousel.backgroundColor = [UIColor clearColor];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.decelerationRate = 0.8;
//    self.carousel.scrollSpeed = 1.0;
//    self.carousel.bounceDistance = 1.0f;
//    self.carousel.contentOffset = CGSizeMake(-60, 0);
    self.carousel.type = iCarouselTypeCylinder;//iCarouselTypeCoverFlow
    
    [self addSubview:self.carousel];
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.dataArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    JJBannerModel* model = [self.dataArray objectAtIndex:index];
    if (NotNull(model.imageUrl)) {
         [imgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        imgView.layer.cornerRadius = 10;
        imgView.layer.masksToBounds = YES;
    });
    
    return imgView;
}

#pragma mark iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return 300;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"jumpURL == %@",[self.dataArray objectAtIndex:index].jumpUrl);
//    HYBrandShopViewController *shopVC = [HYBrandShopViewController new];
//    shopVC.sellerID = 0;
//    [self.navigationController pushViewController:shopVC animated:YES];
    [DCURLRouter pushURLString:[self.dataArray objectAtIndex:index].jumpUrl animated:YES];
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel {
    
}

//- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
//{
//    CGFloat tilt = 0.9;//[carousel valueForOption:iCarouselOptionTilt withDefault:0.9];
//    CGFloat spacing = 0.25;//[carousel valueForOption:iCarouselOptionSpacing withDefault:0.25];
//    CGFloat clampedOffset = MAX(-1.0, MIN(1.0, offset));
//
//    CGFloat itemW = 300;
//    CGFloat distance = 0.5;
//    CGFloat x = (clampedOffset * distance * tilt + offset * spacing) * itemW;
//    CGFloat z = fabs(clampedOffset) * -itemW * 0.5;
//
//    transform = CATransform3DTranslate(transform, x, 0.0, z);
//    return CATransform3DRotate(transform, clampedOffset * M_PI_2 * tilt, 0.0, 1.0, 0.0);
//
//}


@end

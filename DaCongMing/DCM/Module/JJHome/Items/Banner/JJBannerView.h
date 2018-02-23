//
//  BannerView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "JJBannerModel.h"

@interface JJBannerView : UIView

@property (nonatomic,strong) NSMutableArray<JJBannerModel*> * dataArray;//JJBannerModel
@property (nonatomic, strong) iCarousel * carousel;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)configCarousel;

@end

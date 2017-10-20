//
//  HYNoCollectImgView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYNoCollectImgView.h"

@implementation HYNoCollectImgView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        self.image = [UIImage imageNamed:@"NoCollect"];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

@end

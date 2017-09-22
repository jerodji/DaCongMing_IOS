//
//  HYShareView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYShareView.h"

@interface HYShareView()



@end

@implementation HYShareView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            CGPoint tapPoint = [sender locationInView:self];
            if(tapPoint.y < KSCREEN_HEIGHT * 0.5){
                
                [self removeFromSuperview];
            }
            
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupSubviews{
    
}

@end

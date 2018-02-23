//
//  JJLTCView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJLTCView.h"

@interface JJLTCView()

@end

@implementation JJLTCView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height  )];
        self.imgView.layer.cornerRadius = 20;
        self.imgView.layer.masksToBounds = YES;
        [self addSubview:self.imgView];
        
    }
    return self;
}

- (void)updateUIWith:(NSDictionary*)ltcDict
{
    
//    [DCURLRouter pushURLString:<#(nonnull NSString *)#> animated:<#(BOOL)#>];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

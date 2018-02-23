//
//  JJBoutiquCell.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJBoutiquCell.h"

@interface JJBoutiquCell()

@end

@implementation JJBoutiquCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self layerShadowWithColor:UIColorRGB(83, 83, 83) Radius:10.0 Opacity:0.4  Offset:CGSizeMake(0, 0) Path:nil];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.cornerRadius = 10.0;
        _imageView.layer.masksToBounds = YES;
        
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setModel:(JJBoutiquModel *)model {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"%@",model.jumpUrl);
        [DCURLRouter pushURLString:model.jumpUrl animated:YES];
    }];
    [_imageView addGestureRecognizer:tap];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

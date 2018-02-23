//
//  JJTitleView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJTitleView.h"


@interface JJTitleView()
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,assign) TableItemStyle itemType;
@end

@implementation JJTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [JJTitleView loadXIB];
        self.frame = frame;
        _rect = frame;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame itemType:(TableItemStyle)itemType {
    self = [super initWithFrame:frame];
    if (self) {
        self = [JJTitleView loadXIB];
        self.frame = frame;
        _rect = frame;
        _itemType = itemType;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLabel.font = [UIFont fontWithName:FONT_DINOT size:12];
    _englishTitleLabel.font = [UIFont fontWithName:FONT_DINOT size:12];
    //self.userInteractionEnabled = YES;
    [self.moreButton addTarget:self action:@selector(moreGoods:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)drawRect:(CGRect)rect {
    self.frame = _rect; //CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight);
    if (ItemWildRecomend == _itemType) {
        [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
    }
}

- (void)moreGoods:(UIButton*)button {
    NSLog(@"更多商品");
    
    //健康资讯
    if (ItemWildRecomend == _itemType) {
        NSLog(@"健康资讯 更多");
        !_moreNatureCB ? : _moreNatureCB();
    }
}

@end

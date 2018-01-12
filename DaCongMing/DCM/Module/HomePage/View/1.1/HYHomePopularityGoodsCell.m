//
//  HYHomePopularityGoodsCell.m
//  DaCongMing
//
//  Created by Jack on 2018/1/10.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import "HYHomePopularityGoodsCell.h"

@interface HYHomePopularityGoodsCell() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYHomePopularityGoodsCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self);
    }];
}

#pragma mark - lazyload
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

@end

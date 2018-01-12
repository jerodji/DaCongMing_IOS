//
//  HYHomePopularityGoodsLayout.m
//  DaCongMing
//
//  Created by Jack on 2018/1/10.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import "HYHomePopularityGoodsLayout.h"


#define KlineSpace          20
#define KPageItemWidth      220 * WIDTH_MULTIPLE

@implementation HYHomePopularityGoodsLayout


- (void)prepareLayout{
    
    [super prepareLayout];
    //计算cell超出显示的宽度
    CGFloat overWidth = (self.collectionView.width - KPageItemWidth - KlineSpace * 2) / 2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, overWidth + KlineSpace, 0, overWidth + KlineSpace);
    
}

- (CGSize)collectionViewContentSize{
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat contentWidth = cellCount * (KPageItemWidth + KlineSpace);
    return CGSizeMake(contentWidth, self.collectionView.height - 30);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *attributesArray = [NSMutableArray array];
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    return attributes;
}

@end

//
//  HYGoodsCollectionView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodsCollectionView.h"
#import "HYGoodsItemCollectionViewCell.h"

@implementation HYGoodsCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *customLayout = [[UICollectionViewFlowLayout alloc] init];
        customLayout.itemSize = CGSizeMake(KSCREEN_WIDTH / 2 - 10, 340 * WIDTH_MULTIPLE);
        customLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        customLayout.minimumInteritemSpacing = 5;
        customLayout.minimumLineSpacing = 6 * WIDTH_MULTIPLE;      //纵向间距
        customLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        [self setCollectionViewLayout:customLayout];
        self.backgroundColor = self.backgroundColor;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        [self registerClass:[HYGoodsItemCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return self;
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemCollectionViewCell *cell = (HYGoodsItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = KAPP_WHITE_COLOR;
    NSDictionary *dict = _datalist[indexPath.item];
    cell.goodsModel = [HYGoodsItemModel modelWithDictionary:dict];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _datalist[indexPath.item];
    HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:dict];
    
    DLog(@"current itemID is %@",model.item_id);
    
    
    //self.collectionSelect(model.item_id);
    
}

@end

//
//  HYGoodsCollectionView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYGoodsCollectionView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;

@end

//
//  HYMyCollectionShopCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMyCollectShopModel.h"

typedef void(^collectionSelectBlock)(NSString *productID);
typedef void(^cancelCollectBlock)(NSString *shopID);


@interface HYMyCollectionShopCell : UITableViewCell

/** 收藏店铺model */
@property (nonatomic,strong) HYMyCollectShopModel *collectShopModel;

/** 点击collectionBlock */
@property (nonatomic,copy) collectionSelectBlock collectionSelect;

/** 点击取消收藏 */
@property (nonatomic,copy) cancelCollectBlock cancelCollect;


@end

//
//  HYMyCollectionGoodsCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGoodsItemModel.h"
#import "HYMyOrderModel.h"

#warning 我的收藏 订单的商品信息公用

@interface HYMyCollectionGoodsCell : UITableViewCell

/** 收藏的商品model */
@property (nonatomic,strong) HYGoodsItemModel *itemModel;

/** 订单商品信息model */
@property (nonatomic,strong) HYMyOrderDetailsModel *orderDetailModel;

@end

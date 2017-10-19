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

typedef void(^applySaleAfterBlock)();
typedef void(^itemSelectBlock)(BOOL isSelect);

@interface HYMyCollectionGoodsCell : UITableViewCell

/** 收藏的商品model */
@property (nonatomic,strong) HYGoodsItemModel *itemModel;

/** 点击选择按钮回调 */
@property (nonatomic,copy) itemSelectBlock itemSelect;

/** 订单商品信息model */
@property (nonatomic,strong) HYMyOrderDetailsModel *orderDetailModel;

/** 申请售后按钮 */
@property (nonatomic,strong) UIButton *applySellAfterBtn;

/** 点击申请售后回调 */
@property (nonatomic,copy) applySaleAfterBlock applySaleAction;



@end

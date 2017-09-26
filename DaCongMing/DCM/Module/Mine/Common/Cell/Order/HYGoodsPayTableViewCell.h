//
//  HYGoodsPayTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^orderPayMode)(NSInteger mode);

@interface HYGoodsPayTableViewCell : UITableViewCell

/** orderMode */
@property (nonatomic,strong) HYCreateOrder *orderModel;

/** 支付方式回调 */
@property (nonatomic,copy) orderPayMode orderPayModeBlock;

@end

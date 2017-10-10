//
//  HYReceiverInfoTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCreateOrder.h"

typedef void(^returnHomeBlock)();
typedef void(^lookOrderInfoBlock)();
typedef void(^payAgainBlock)();

@interface HYReceiverInfoTableViewCell : UITableViewCell

/** 是否支付成功 */
@property (nonatomic,assign) BOOL isPaySuccess;

/** address */
@property (nonatomic,strong) HYAddressMap *addressMap;

/** 回到主页 */
@property (nonatomic,copy) returnHomeBlock returnHome;
/** 查看订单 */
@property (nonatomic,copy) lookOrderInfoBlock lookOrderInfo;
/** 重新支付   */
@property (nonatomic,copy) payAgainBlock payAgain;

@end

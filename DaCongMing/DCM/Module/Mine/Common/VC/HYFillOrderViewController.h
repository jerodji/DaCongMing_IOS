//
//  HYFillOrderViewController.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYFillOrderViewController : HYBaseViewController

/** model */
@property (nonatomic,strong) HYGoodsDetailModel *goodsDetailModel;
/** 规格 */
@property (nonatomic,strong) NSString *specifical;
/** 数量 */
@property (nonatomic,assign) NSInteger buyCount;

@end

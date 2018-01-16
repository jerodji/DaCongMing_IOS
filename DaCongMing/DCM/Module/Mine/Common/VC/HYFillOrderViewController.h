//
//  HYFillOrderViewController.h
//  DaCongMing
//
//

#import "HYBaseViewController.h"

@interface HYFillOrderViewController : HYBaseViewController

/** model */
@property (nonatomic,strong) HYGoodsDetailModel *goodsDetailModel;
/** 规格 */
@property (nonatomic,strong) NSString *specifical;
/** 数量 */
@property (nonatomic,assign) NSInteger buyCount;
/** 订单号（重复购买） */
@property (nonatomic,copy) NSString *orderID;

/** 购物车编号(购物车结算) */
@property (nonatomic,copy) NSString *guids;
/** 是否重复购买 */
@property (nonatomic,assign) BOOL isReBuy;

@end

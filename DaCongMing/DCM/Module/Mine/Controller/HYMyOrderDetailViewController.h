//
//  HYMyOrderDetailViewController.h
//  DaCongMing
//
//

#import "HYBaseViewController.h"
#import "HYMyOrderModel.h"

@interface HYMyOrderDetailViewController : HYBaseViewController

/** orderModel */
@property (nonatomic,strong) HYMyOrderModel *orderModel;

@property (nonatomic,assign) NSInteger purchesTag;

@end

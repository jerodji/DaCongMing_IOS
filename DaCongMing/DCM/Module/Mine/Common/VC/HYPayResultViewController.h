//
//  HYPayResultViewController.h
//  DaCongMing
//
//

#import "HYBaseViewController.h"
#import "HYCreateOrder.h"


@interface HYPayResultViewController : HYBaseViewController

/** 是否支付成功 */
@property (nonatomic,assign) BOOL isPaySuccess;

/** address */
@property (nonatomic,strong) HYAddressMap *addressMap;

@end

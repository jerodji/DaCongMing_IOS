//
//  HYMyAddressViewController.h
//  DaCongMing
//
//

#import "HYBaseViewController.h"
#import "HYMyAddressModel.h"

typedef void(^selectAddressBlock)(HYMyAddressModel *addressModel);

@interface HYMyAddressViewController : HYBaseViewController

/** 是否从订单跳转过来 */
@property (nonatomic,assign) BOOL isJump;

/** 选择地址回传block */
@property (nonatomic,copy) selectAddressBlock selectAddBlock;

@end

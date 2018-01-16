//
//  HYAlipayManager.h
//  DaCongMing
//
//

#import "HYBaseModel.h"
#import <AlipaySDK/AlipaySDK.h>

typedef void(^AlipaySuccessBlock)();
typedef void(^AlipayFailedBlock)();

@interface HYAlipayManager : HYBaseModel

+ (void)alipayWithOrderString:(NSString *)orderString success:(AlipaySuccessBlock)success failed:(AlipayFailedBlock)failBlock;

@end

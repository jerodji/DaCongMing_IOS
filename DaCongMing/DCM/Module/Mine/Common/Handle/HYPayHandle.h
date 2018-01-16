//
//  HYPayHandle.h
//  DaCongMing
//
//

#import "HYBaseModel.h"
#import "HYWeChatPayModel.h"

@interface HYPayHandle : HYBaseModel

+ (void)alipayWithOrderID:(NSString *)orderID coupon_guid:(NSString *)coupon_guid buyerMessage:(NSString *)buyerMessage complectionBlock:(void(^)(NSString *sign))complection;

+ (void)weChatPayWithOrder:(NSString *)orderID coupon_guid:(NSString *)coupon_guid buyerMessage:(NSString *)buyerMessage complectionBlock:(void(^)(HYWeChatPayModel *weChatPayModel))complection;

@end

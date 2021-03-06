//
//  HYRequestOrderHandle.h
//  DaCongMing
//
//

#import "HYBaseModel.h"
#import "HYMyOrderModel.h"

@interface HYRequestOrderHandle : HYBaseModel

/**
 *  获取所有订单
 */
+ (void)requestAllOrderDataWithPageNo:(NSInteger)pageNo andPage:(NSInteger)pageSize ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  请求订单
 */
+ (void)requestOrderDataWithState:(NSInteger)order_state pageNo:(NSInteger )pageNo andPage:(NSInteger )pageSize complectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  获取订单详情
 */
+ (void)requestOrderDetailWithOrderID:(NSString *)orderID complectionBlock:(void(^)(HYMyOrderModel *orderModel))complection;

/**
 *  请求优惠券
 */
+ (void)requestDiscountCouponComplectionBlock:(void(^)(NSArray *datalist))complection noDataBlock:(void(^)())noDiscountCoupon;

/**
 *  收货地址
 */
+ (void)requestReceivedAddressComplectionBlock:(void(^)(NSArray *datalist))complection noDataBlock:(void(^)())noAddressBlock;

/**
 *  添加收货地址
 */
+ (void)addReceivedAddress:(NSDictionary *)addressDict ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  修改收货地址
 */
+ (void)editReceivedAddress:(NSDictionary *)addressDict ComplectionBlock:(void(^)(BOOL isSuccess))complection;


/**
 *  修改默认地址
 */
+ (void)setDefaultReceivedAddress:(NSString *)newAddress_id oldAddressID:(NSString *)oldAddressID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  删除收货地址
 */
+ (void)deleteReceivedAddress:(NSString *)addressID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  确认收货
 */
+ (void)confirmReceiveProductWithOrderID:(NSString *)ordreID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  删除订单
 */
+ (void)deleteOrderWithOrderID:(NSString *)orderID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  获取最近的浏览记录
 */
+ (void)requestRecentViewWithpageNo:(NSInteger )pageNo complectionBlock:(void(^)(NSArray *datalist))complection;

@end

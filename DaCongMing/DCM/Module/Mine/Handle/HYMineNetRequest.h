//
//  HYMineNetRequest.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>
#import "HYMyUserInfo.h"
#import "HYRefundModel.h"

@interface HYMineNetRequest : NSObject

/**
 *  获取我的购物车 收藏数量
 */
+ (void)getMyUserInfoComplectionBlock:(void(^)(HYMyUserInfo *myUserInfo))complection;

/**
 *  获取我的收藏商品
 */
+ (void)getMyCollectGoodsWithPageNo:(NSInteger )PageNo ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  获取我的收藏商品
 */
+ (void)getMyCollectShopWithPageNo:(NSInteger )PageNo ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  删除我的收藏商品
 */
+ (void)deleteMyCollectionGoodsWithItemIDs:(NSString *)itemIDs ComplectionBlock:(void(^)(BOOL isSuccess))complection;


/**
 *  获取售后服务列表
 */
+ (void)getMySellAfterWithPageNo:(NSInteger )PageNo ComplectionBlock:(void(^)(NSArray *datalist))complection;

/**
 *  删除订单
 */
+ (void)deleteOrderWithOrderID:(NSString *)orderID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  我的分享
 */
+ (void)getMyShareWithComplectionBlock:(void(^)(NSDictionary *shareDict))complection;

/**
 *  提交申请售后
 */
+ (void)submitApplySellAfterWithSellerID:(NSString *)sellerID orderID:(NSString *)orderID itemDetail:(NSString *)itemDetail reason:(NSString *)reason ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  获取售后详情
 */
+ (void)getRefundDetailWithRefundID:(NSString *)refundID  ComplectionBlock:(void(^)(HYRefundModel *refundModel))complection;

/**
 *  提交退货物流信息
 */
+ (void)submitlogisticsInfoWithRefundID:(NSString *)refundID logisticsCompany:(NSString *)company logisticsNum:(NSString *)number ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  评价
 */
+ (void)commentWithOrderID:(NSString *)orderID jsonText:(NSString *)jsonText ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  获取物流信息URL
 */
+ (void)getlogisticsUrlWithOrderID:(NSString *)orderID  ComplectionBlock:(void(^)(NSString *url))complection;

/**
 *  获取系统消息
 */
+ (void)getSystemInfoWithPageNo:(NSInteger)pageNo ComplectionBlock:(void(^)(NSArray *datalist))complection;

@end

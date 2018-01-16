//
//  HYGoodsHandle.h
//  DaCongMing
//
//

#import "HYBaseModel.h"
#import "HYGoodsDetailModel.h"
#import "HYCreateOrder.h"
#import "HYMyAddressModel.h"
#import "HYCommentModel.h"

@interface HYGoodsHandle : HYBaseModel

/**
 *  请求商品列表
 */
+ (void)requestGoodsListItem_type:(NSString *)item_type pageNo:(NSInteger)pageNo sortType:(NSString *)sortType keyword:(NSString *)keyword complectionBlock:(void (^)(NSArray *datalist))complection;

/**
 *  请求商品详情
 */
+ (void)requestProductsDetailWithGoodsID:(NSString *)goodsID andToken:(NSString *)token complectionBlock:(void(^)(HYGoodsDetailModel *model,HYCommentModel *commentModel))complection;

/**
 *  创建订单
 */
+ (void)createOrderWithGuid:(NSString *)guid itemID:(NSString *)itemID count:(NSInteger)count sellerID:(NSString *)sellerID andUnit:(NSString *)unit complectionBlock:(void(^)(HYCreateOrder *order))complection;

/**
 *  去付款
 */
+ (void)payerWithOrderID:(NSString *)orderID complectionBlock:(void(^)(HYCreateOrder *order))complection;

/**
 *  重复购买
 */
+ (void)createOrderWithOrderID:(NSString *)orderID complectionBlock:(void(^)(HYCreateOrder *order))complection;

/**
 *  修改订单收货地址
 */
+ (void)changeOrderReceiveAddressOrderID:(NSString *)orderID addressModel:(HYMyAddressModel *)addressModel ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  添加到购物车
 */
+ (void)addToShoppingCartsItemID:(NSString *)itemID count:(NSInteger)count andUnit:(NSString *)unit ComplectionBlock:(void(^)(BOOL isSuccess,NSString *cartsCount))complection;

/**
 *  添加收藏
 */
+ (void)addToCollectionGoodsWithItemID:(NSString *)itemID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  店铺首页
 */
+ (void)getBrandsShopWithSellerID:(NSString *)sellerID ComplectionBlock:(void(^)(NSDictionary *dict))complection;

/**
 *  店铺所有商品
 */
+ (void)getBrandsShopProductWithSeller:(NSString *)sellerID Type:(NSInteger)type pageNo:(NSInteger)pageNO ComplectionBlock:(void (^)(NSArray *datalist))complection;

/**
 *  收藏店铺
 */
+ (void)collectShopWithSellerID:(NSString *)sellerID ComplectionBlock:(void(^)(BOOL isSuccess))complection;

/**
 *  取消收藏店铺
 */
+ (void)cancelCollectShopWithSellerIDs:(NSString *)sellerIDs ComplectionBlock:(void(^)(BOOL isSuccess))complection;


/**
 *  请求商品详情评价
 */
+ (void)requestProductsCommentsWithProductID:(NSString *)productID pageNo:(NSInteger) pageNo complectionBlock:(void(^)(NSArray *datalist))complection;

@end

//
//  HYGoodsDetailBottomView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>


typedef void(^shoppingCartsBlock)();
typedef void(^brandShopBlock)();
typedef void(^collectBlock)();
typedef void(^addToCartsBlock)();
typedef void(^buyNowBlock)();

@interface HYGoodsDetailBottomView : UIView

/** 购物车 */
@property (nonatomic,copy) shoppingCartsBlock shoppingCartsAction;
/** 品牌店铺 */
@property (nonatomic,copy) brandShopBlock brandShopAction;
/** 收藏 */
@property (nonatomic,copy) collectBlock collectAction;
/** 加入购物车 */
@property (nonatomic,copy) addToCartsBlock addToCartsAction;
/** 立即购买 */
@property (nonatomic,copy) buyNowBlock buyNowAction;

/** shoppingCarts */
@property (nonatomic,strong) HYButton *cartsBtn;
/** brandStoreBtn */
@property (nonatomic,strong) HYButton *brandStoreBtn;
/** collectionBtn */
@property (nonatomic,strong) HYButton *collectionBtn;
/** 加入购物车 */
@property (nonatomic,strong) UIButton *addToCartsBtn;
/** 立即购买 */
@property (nonatomic,strong) UIButton *buyBtn;

@end

//
//  HYBrandShopViewController.h
//  DaCongMing
//
//


/**
 * <#Description#>
 */

#import "HYBaseViewController.h"

typedef NS_ENUM(NSUInteger, HYBrandShopTopItem) {
    HYBrandShopTopItemHome = 0,
    HYBrandShopTopItemAll,
    HYBrandShopTopItemHotSale,
    HYBrandShopTopItemNew
};

@interface HYBrandShopViewController : HYBaseViewController

/** 商家ID */
@property (nonatomic,copy) NSString *sellerID;
/** 顶部四个按钮 */
@property (nonatomic,assign) HYBrandShopTopItem topItem;

@end

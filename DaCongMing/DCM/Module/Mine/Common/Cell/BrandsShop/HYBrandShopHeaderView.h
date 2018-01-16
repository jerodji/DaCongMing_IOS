//
//  HYBrandShopHeaderView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYBrandShopInfoModel.h"

typedef void(^BrandShopTopBtnSelectBlcok)(NSInteger tag);

@interface HYBrandShopHeaderView : UIView

/** 商家信息 */
@property (nonatomic,strong) HYBrandShopStoreInfo *storeInfo;

@property (nonatomic,copy) BrandShopTopBtnSelectBlcok topBtnSelectBlock;

@end

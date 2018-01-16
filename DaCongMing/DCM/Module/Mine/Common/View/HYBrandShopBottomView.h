//
//  HYBrandShopBottomView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@protocol HYBrandsShopBottomActionDelegate <NSObject>

- (void)brandsBottomBtnTapIndex:(NSInteger)index;

@end

@interface HYBrandShopBottomView : UIView

/** allGoodsBtn */
@property (nonatomic,strong) UIButton *allGoodsBtn;
/** hotSaleBtn */
@property (nonatomic,strong) UIButton *hotSaleBtn;
/** newProductBtn */
@property (nonatomic,strong) UIButton *recentNewBtn;

/** delegate */
@property (nonatomic,weak) id<HYBrandsShopBottomActionDelegate>delegate;

@end

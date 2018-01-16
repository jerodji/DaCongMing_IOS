//
//  HYShoppingCartsSellerView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYCartsModel.h"

@protocol HYSelectCartSellerDelegate <NSObject>

/**
 *  购物车商家选择按钮点击
 */
- (void)cartSellerSelect:(BOOL)isSelect WithIndexPath:(NSInteger )index;

@end

@interface HYShoppingCartsSellerView : UITableViewHeaderFooterView

/** 商家model */
@property (nonatomic,strong) HYCartsSeller *cartsSeller;

/** indexPath */
@property (nonatomic,assign) NSInteger index;

/** delegate */
@property (nonatomic,weak) id<HYSelectCartSellerDelegate>delegate;

@end

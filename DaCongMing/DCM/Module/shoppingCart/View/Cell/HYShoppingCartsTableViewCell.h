//
//  HYShoppingCartsTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYCartsModel.h"

typedef void(^cartsChangedBlock)(HYCartsSeller *cartsSeller,NSIndexPath *changeIndexPath);

@interface HYShoppingCartsTableViewCell : UITableViewCell

/** 商家model */
@property (nonatomic,strong) HYCartsSeller *cartsSeller;

/** indexPath */
@property (nonatomic,strong) NSIndexPath *indexPath;

/** 购物车发生变化 */
@property (nonatomic,copy) cartsChangedBlock shoppingCartsChangedBlock;

@end

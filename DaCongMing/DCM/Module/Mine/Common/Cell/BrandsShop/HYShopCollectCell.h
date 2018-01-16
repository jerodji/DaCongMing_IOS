//
//  HYShopCollectCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYBrandShopInfoModel.h"

@protocol HYShopCollectDelegate <NSObject>

- (void)shopCollectClick:(BOOL)isCollect;

@end

@interface HYShopCollectCell : UITableViewCell

/** 店铺信息 */
@property (nonatomic,strong) HYBrandShopInfoModel *infoModel;

/** delegate */
@property (nonatomic,weak) id<HYShopCollectDelegate> delegate;

@end

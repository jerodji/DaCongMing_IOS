//
//  HYMyOrderTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYMyOrderModel.h"

@protocol HYMyOrderBtnActionDelegate <NSObject>

- (void)myOrderBtnActionWithStr:(NSString *)title WithIndexPath:(NSIndexPath *)indexPath;

@end

@interface HYMyOrderTableViewCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYMyOrderModel *model;

/** ind */
@property (nonatomic,strong) NSIndexPath *indexPath;

/** delegate */
@property (nonatomic,weak) id<HYMyOrderBtnActionDelegate>delegate;

@end

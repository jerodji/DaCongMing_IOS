//
//  HYOrderTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^myAllOrderBlock)(void);

@protocol HYMyOrderActionDelegate <NSObject>

- (void)jumpToMyOrderDetailVCWithTag:(NSInteger)tag;

@end

@interface HYOrderTableViewCell : UITableViewCell

/** myAllOrderBlock */
@property (nonatomic,copy) myAllOrderBlock myAllOrder;
/** delegate */
@property (nonatomic,weak) id<HYMyOrderActionDelegate> delegate;

@end

//
//  HYSendBackInfoCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYRefundModel.h"

@protocol HYSumbitLogisticInfoDelegate <NSObject>

- (void)submitLogisticWithCompany:(NSString *)company andNumber:(NSString *)number;

@end

@interface HYSendBackInfoCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYRefundModel *model;

/** delegate */
@property (nonatomic,weak) id<HYSumbitLogisticInfoDelegate> delegate;

@end

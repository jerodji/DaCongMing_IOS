//
//  HYHomePageView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYHomePageModel.h"

@interface HYHomePageView : UITableView <SDCycleScrollViewDelegate>

/** 数据源 */
@property (nonatomic,strong) HYHomePageModel *model;

@end

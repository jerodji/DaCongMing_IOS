//
//  HYBaseTableViewController.h
//  live
//
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface HYBaseTableViewController : UITableViewController <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) NSMutableArray *datalist;

@end

//
//  HYHomeTitleScrollCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYHomePageModel.h"

typedef void(^collectionSelectBlock)(NSString *productID);

@interface HYHomeTitleScrollCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYHomePageModel *model;

/** 点击collectionBlock */
@property (nonatomic,copy) collectionSelectBlock collectionSelect;

/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;

@end

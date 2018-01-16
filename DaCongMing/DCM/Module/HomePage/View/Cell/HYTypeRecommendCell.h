//
//  HYTypeRecommendCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYHomePageModel.h"
#import "HYTypeRecommendItemModel.h"

typedef void(^RecommendItemSelectBlock)(NSString *keyword,NSString *typeID);

@interface HYTypeRecommendCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYHomePageModel *model;
/** 点击回调 */
@property (nonatomic,copy) RecommendItemSelectBlock selectItemBlock;

@end

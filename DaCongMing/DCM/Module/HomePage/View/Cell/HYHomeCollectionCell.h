//
//  HYHomeCollectionCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYHomePageModel.h"

typedef void(^SelectItemBlock)(NSString *itemType);

@interface HYHomeCollectionCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYHomePageModel *model;
/** 点击brands回调 */
@property (nonatomic,copy) SelectItemBlock selectItemBlock;

@end

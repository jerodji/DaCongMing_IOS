//
//  HYRecommendPayModeCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYParterPayModel.h"

@interface HYRecommendPayModeCell : UITableViewCell


@property (nonatomic,strong) NSIndexPath *indexPath;
/** model */
@property (nonatomic,strong) HYParterPayModel *model;
/** 选择按钮 */
@property (nonatomic,strong) UIButton *selectBtn;

- (void)setIConImage:(NSString *)icon andTitle:(NSString *)title;

@end

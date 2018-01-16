//
//  HYTextFieldTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@class HYTextFieldTableViewCell;

@protocol HYTextFieldCellDelegate <NSObject>

//textView刷新tableViewCell
- (void)textFieldCellInput:(HYTextFieldTableViewCell *)cell;

@end

@interface HYTextFieldTableViewCell : UITableViewCell

/** title */
@property (nonatomic,copy) NSString *title;

/** textField */
@property (nonatomic,strong) UITextField *textField;

/** delegate */
@property (nonatomic,weak) id<HYTextFieldCellDelegate>delegate;

@property (nonatomic,strong) NSIndexPath *indexPath;

/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;

@end

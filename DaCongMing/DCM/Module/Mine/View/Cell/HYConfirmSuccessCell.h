//
//  HYConfirmSuccessCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^LookOrderBlock)();
typedef void(^CommentBlock)();

@interface HYConfirmSuccessCell : UITableViewCell

/** 查看订单 */
@property (nonatomic,copy) LookOrderBlock lookOrderBlock;
/** 评价 */
@property (nonatomic,copy) CommentBlock commentBlock;

@end

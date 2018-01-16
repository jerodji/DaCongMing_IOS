//
//  HYCartsBottomView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^checkAllActionBlock)(BOOL isCheckAll);

typedef void(^payActionBlock)();

@interface HYCartsBottomView : UIView

/** 是否全选 */
@property (nonatomic,copy) checkAllActionBlock checkAllBlock;

/** 结算 */
@property (nonatomic,copy) payActionBlock payAction;

/** checkAllBtn */
@property (nonatomic,strong) HYButton *checkAllBtn;

/** 价格 */
@property (nonatomic,copy) NSString *amount;

@end

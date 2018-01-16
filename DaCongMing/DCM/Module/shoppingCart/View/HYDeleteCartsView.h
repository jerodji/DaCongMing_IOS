//
//  HYDeleteCartsView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^deleteViewcheckAllActionBlock)(BOOL isCheckAll);

typedef void(^deleteActionBlock)();

@interface HYDeleteCartsView : UIView

/** checkAllBtn */
@property (nonatomic,strong) HYButton *checkAllBtn;

/** 是否全选 */
@property (nonatomic,copy) deleteViewcheckAllActionBlock deleteCheckAllBlock;

/** 删除 */
@property (nonatomic,copy) deleteActionBlock deleteBlock;

@end

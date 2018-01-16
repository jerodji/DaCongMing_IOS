//
//  HYBuyCountEditView.h
//  DaCongMing
//    
//

#import <UIKit/UIKit.h>

typedef void(^countCallbackBlock)(NSInteger count);

@interface HYBuyCountEditView : UIView

/** 数量 */
@property (nonatomic,assign) NSInteger count;
/** 回调数量 */
@property (nonatomic,copy) countCallbackBlock countCallback;

@end

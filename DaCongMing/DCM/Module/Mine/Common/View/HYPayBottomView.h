//
//  HYPayBottomView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^PayBlock)();

@interface HYPayBottomView : UIView

/** 支付金额 */
@property (nonatomic,strong) NSString *payAmount;
/** 支付按钮 */
@property (nonatomic,copy) PayBlock payBlock;

@end

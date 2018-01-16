//
//  HYCustomAlert.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^confirmActionBlcok)();

@interface HYCustomAlert : UIView

/** 确定 */
@property (nonatomic,copy) confirmActionBlcok actionBlock;

- (instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title content:(NSString *)content confirmBlock:(void(^)())confirmAction;

- (void)showCustomAlert;

@end

//
//  HYInviteParterView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^jumpToPayVCBlock)(void);

@interface HYInviteParterView : UIView

/** 立即支付 */
@property (nonatomic,copy) jumpToPayVCBlock payBlock;

- (void)showInviteView;

@end

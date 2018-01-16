//
//  HYAuthPhoneView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^authSuccessBlock)();

@interface HYAuthPhoneView : UIView

/** 是否绑定手机 */
@property (nonatomic,assign) BOOL isBindPhone;

/** phoneTextField */
@property (nonatomic,strong) UITextField *phoneTextField;

/** authCodeTextField */
@property (nonatomic,strong) UITextField *authCodeTextField;

/** 验证手机号 */
@property (nonatomic,strong) authSuccessBlock authPhoneSuccess;

@end

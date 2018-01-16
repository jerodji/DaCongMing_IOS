//
//  HYLoginView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^weChatSuccessBlock)();
typedef void(^userLoginSuccessBlock)();
typedef void(^loginVCCloseBlock)();
typedef void(^forgetPasswordBlock)();

@interface HYLoginView : UIView

/** WeChatToken */
@property (nonatomic,copy) NSString *token;

/** weChatCallbackCode */
@property (nonatomic,copy) NSString *weChatCallbackCode;

/** block */
@property (nonatomic,copy) weChatSuccessBlock weChatBlock;

/** login */
@property (nonatomic,copy) userLoginSuccessBlock userLoginSuccess;

/** close */
@property (nonatomic,copy) loginVCCloseBlock loginCloseBlock;

/** 忘记密码 */
@property (nonatomic,copy) forgetPasswordBlock forgetPassoword;

@end

//
//  HYSetPasswordViewController.h
//  DaCongMing
//
//

#import "HYBaseViewController.h"

@interface HYSetPasswordViewController : HYBaseViewController

/** phone */
@property (nonatomic,copy) NSString *phone;
/** 验证码 （设置密码页面跳转） */
@property (nonatomic,copy) NSString *authCode;

@end

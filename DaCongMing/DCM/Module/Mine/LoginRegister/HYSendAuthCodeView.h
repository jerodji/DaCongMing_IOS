//
//  HYSendAuthCodeView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^AuthCodeSuccess)(NSString *authCode);

@interface HYSendAuthCodeView : UIView

/** 手机号 */
@property (nonatomic,copy) NSString *phone;
/** 验证码验证成功 */
@property (nonatomic,copy) AuthCodeSuccess authSuccessBlock;

@end

//
//  HYParterPayModel.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>

@interface HYParterPayModel : NSObject

/** 推荐类型 */
@property (nonatomic,copy) NSString *recommendType;
/** 支付时间 */
@property (nonatomic,copy) NSString *payTime;
/** 邀请人 */
@property (nonatomic,copy) NSString *inviter;

@property (nonatomic,copy) NSString *intro;
/** 支付mode  0 支付宝  1 微信*/
@property (nonatomic,assign) NSInteger payMode;
/** 支付金额 */
@property (nonatomic,copy) NSString *payMoney;

@end

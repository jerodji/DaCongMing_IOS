//
//  HYUserHandle.h
//  DaCongMing
//
//

#import "HYBaseModel.h"
#import "HYCreateOrder.h"

@interface HYUserHandle : HYBaseModel

/*!
     手机号登录
 */
+ (void)userLoginWithPhone:(NSString *)phone password:(NSString *)password complectionBlock:(void(^)(BOOL isLoginSuccess))complection;

/**
 *  获取我的购物车 收藏数量
 */
+ (void)getMyUserInfoComplectionBlock:(void(^)(HYUserModel *userModel))complection;

/*!
     获取验证码
 */
+ (void)getAuthCodeWithPhone:(NSString *)phone complectionBlock:(void(^)(BOOL isSuccess))complection;

/*!
     验证手机验证码
 */
+ (void)verifyAuthCodeWithPhone:(NSString *)phone authCode:(NSString *)authCode complectionBlock:(void(^)(BOOL isSuccess))complection;

/*!
     设置用户密码
 */
+ (void)setPasswordWithPhone:(NSString *)phone password:(NSString *)password authCode:(NSString *)authCode complectionBlock:(void(^)(BOOL isSuccess))complection;

/*!
     用户反馈
 */
+ (void)userFeedBackWithText:(NSString *)text complectionBlock:(void(^)(BOOL isSuccess))complection;


/** 获取推荐合伙人支付订单 */
+ (void)getParterRecommendPayOrderComplectionBlock:(void(^)(HYCreateOrder *order))complection;

/*!
 @method
 @brief 跳转到登录VC
 @param fromVC  当前的VC
 */
+ (BOOL)jumpToLoginViewControllerFromVC:(UIViewController *)fromVC;

/*!
     退出登录
 */
+ (void)userLogoutWithcomplectionBlock:(void(^)(BOOL isSuccess))complection;

/*!
 @method
 @brief 跳回首页
 */
+ (void)jumpToHomePageVC;

@end

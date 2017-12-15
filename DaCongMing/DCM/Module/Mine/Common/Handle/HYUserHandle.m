//
//  HYUserHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYUserHandle.h"
#import "HYLoginViewController.h"

@implementation HYUserHandle

+ (void)userLoginWithPhone:(NSString *)phone password:(NSString *)password complectionBlock:(void (^)(BOOL isLoginSuccess))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"user_phone"];
    [param setValue:password forKey:@"user_pwd"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Login withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                
                HYUserModel *user = [HYUserModel sharedInstance];
                [user modelSetWithDictionary:dict];
                complection(YES);
                
                //缓存用户名和密码
                [KUSERDEFAULTS setValue:phone forKey:KUserPhone];
                [KUSERDEFAULTS setValue:password forKey:KUserPassword];
                [KUSERDEFAULTS setValue:@"phone" forKey:KUserLoginType];
                [KUSERDEFAULTS synchronize];
                
                [HYPlistTools archiveObject:user withName:KUserModelData];

            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"用户名或密码错误"];
            }
        }
        else{
            
            
        }
        
    }];
}

+ (void)getMyUserInfoComplectionBlock:(void (^)(HYUserModel *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetUserInfo withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
                [userDict setValue:dict forKey:@"userInfo"];
                [userDict setValue:[HYUserModel sharedInstance].token forKey:@"token"];
                
                HYUserModel *model = [HYUserModel sharedInstance];
                [model modelSetWithDictionary:userDict];
                [HYPlistTools archiveObject:model withName:KUserModelData];
                complection(model);
            }
            else{
                complection(nil);
            }
        }
        else{
            
            complection(nil);
        }
    }];
}

+ (void)getParterRecommendPayOrderComplectionBlock:(void (^)(HYCreateOrder *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CreateParterRecommendOrder withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                HYCreateOrder *model = [HYCreateOrder modelWithDictionary:dict];
                complection(model);
            }
            else{
                complection(nil);
                [JRToast showWithText:@"获取订单出现了问题"];
            }
        }
        else{
            
            [JRToast showWithText:@"服务器游走去了"];
            complection(nil);
        }
    }];
}

+ (void)getAuthCodeWithPhone:(NSString *)phone complectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetAuthCode withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取验证码失败"];
            }
        }
        else{
            
        }
        
    }];
}

+ (void)verifyAuthCodeWithPhone:(NSString *)phone authCode:(NSString *)authCode complectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:authCode forKey:@"phoneCode"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_VerifyAuthCode withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else if (code == 002){
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"该手机号已经绑定了"];
            }
            else if (code == 006){
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"该手机号未注册"];

            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"验证码错误"];
            }
        }
        
    }];
}

+ (void)setPasswordWithPhone:(NSString *)phone password:(NSString *)password authCode:(NSString *)authCode complectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:password forKey:@"user_pwd"];
    [param setValue:authCode forKey:@"phoneCode"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SetPassword withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            NSString *errorMsg = [returnData objectForKey:@"data"][@"error_msg"];
            if (code == 000) {
                
                complection(YES);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"设置密码成功"];

            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:errorMsg];
            }
        }
        
    }];
}

+ (void)userFeedBackWithText:(NSString *)text complectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:text forKey:@"feedbackMsg"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_UserFeedback withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"反馈出错"];
            }
        }
        
    }];
}

+ (BOOL)jumpToLoginViewControllerFromVC:(UIViewController *)fromVC{
    
    if (![HYUserModel sharedInstance].token) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请登录后操作"];
        HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
        [fromVC presentViewController:loginVC animated:YES completion:nil];
        
        return YES;
    }
    
    return NO;
}

+ (void)userLogoutWithcomplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Logout withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
            }
        }
        
    }];
}

+ (void)jumpToHomePageVC{
    
    HYTabBarController *tabBar = [[HYTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}

@end

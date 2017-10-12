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
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                
                HYUserModel *user = [HYUserModel sharedInstance];
                [user modelSetWithDictionary:dict];
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"用户名或密码错误"];
            }
        }
        
    }];
}

+ (void)getAuthCodeWithPhone:(NSString *)phone complectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetAuthCode withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取验证码失败"];
            }
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
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"验证码错误"];
            }
        }
        
    }];
}

+ (void)setPasswordWithPhone:(NSString *)phone password:(NSString *)password complectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phoneNum"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:password forKey:@"user_pwd"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SetPassword withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                complection(NO);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"设置密码出现错误"];
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
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
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

+ (void)jumpToHomePageVC{
    
    HYTabBarController *tabBar = [[HYTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}

@end

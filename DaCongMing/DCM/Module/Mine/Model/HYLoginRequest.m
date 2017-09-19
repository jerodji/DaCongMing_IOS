//
//  HYLoginRequest.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYLoginRequest.h"

@implementation HYLoginRequest

+ (void)userLoginWithPhone:(NSString *)phone password:(NSString *)password complectionBlock:(void (^)(BOOL isLoginSuccess))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"user_phone"];
    [param setValue:password forKey:@"user_pwd"];
    
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Login withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            int code =[[returnData objectForKey:@"successed"] intValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"用户名或密码错误"];
                complection(NO);
            }
        }
        
    }];
}

@end

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

+ (void)jumpToLoginViewControllerFromVC:(UIViewController *)fromVC{
    
    HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
    [fromVC presentViewController:loginVC animated:YES completion:nil];
}

@end

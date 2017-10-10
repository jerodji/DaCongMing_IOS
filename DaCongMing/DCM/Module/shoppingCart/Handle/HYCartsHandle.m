//
//  HYCartsHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCartsHandle.h"



@implementation HYCartsHandle

+ (void)showMyShoppingCartsWithComplectionBlock:(void (^)(HYCartsModel *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    
    if (![HYUserModel sharedInstance].token) {
        
        complection(nil);
        return;
    }
    
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_ShowShppingCarts withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"][@"dataList"];
                HYCartsModel *model = [HYCartsModel modelWithDictionary:dict];
                complection(model);
            }
            else{
                
                complection(nil);
            }
        }
    }];
    
}

@end

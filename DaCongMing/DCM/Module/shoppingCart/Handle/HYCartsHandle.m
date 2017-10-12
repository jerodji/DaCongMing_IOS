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

+ (void)calculateCartsAmountWithGuid:(NSString *)guid ComplectionBlock:(void (^)(NSString *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:guid forKey:@"totalC_array"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CalculateCartsAmount withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                complection(dict[@"totalAmount"]);
            }
            else{
                
                complection(nil);
            }
        }
    }];
}

+ (void)bulkEditingCartsAmountWithGuid:(NSString *)editJson ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:editJson forKey:@"editC_json"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_BulkEditShoppingCarts withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                DLog(@"%@",dict);
                complection(YES);
            }
            else{
                
                complection(NO);
            }
        }
        else{
            
            complection(NO);

        }
    }];
}

@end

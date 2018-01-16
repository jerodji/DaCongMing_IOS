//
//  HYCartsHandle.m
//  DaCongMing
//
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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"][@"dataList"];
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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                complection(dict[@"totalAmount"]);
            }
            else{
                
                complection(nil);
            }
        }
    }];
}

+ (void)bulkEditingCartsAmountWithGuid:(NSString *)editJson ComplectionBlock:(void (^)(BOOL,NSString*))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:editJson forKey:@"editC_json"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_BulkEditShoppingCarts withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSString *count = [NSString stringWithFormat:@"%@",[[returnData objectForKey:@"data"] objectForKey:@"cartItemCount"]];
                complection(YES,count);
            }
            else{
                
                complection(NO,@"0");

            }
        }
        else{
            
            complection(NO,@"0");

        }
    }];
}

+ (void)settleCartsWithGuid:(NSString *)guids ComplectionBlock:(void (^)(HYCreateOrder *))complection{
    
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:guids forKey:@"cart_guids"];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SettleShoppingCarts withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                HYCreateOrder *model = [HYCreateOrder modelWithDictionary:dict];
                complection(model);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"订单创建出错!"];
            }
        }
        else{
            
            complection(nil);
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"订单创建出错!"];
        }
    }];
}

+ (void)deleteCartsAmountWithGuids:(NSString *)guids ComplectionBlock:(void (^)(BOOL,NSString *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:guids forKey:@"arrayGuid"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_DeleteShoppingCarts withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSString *count = [NSString stringWithFormat:@"%@",[[returnData objectForKey:@"data"] objectForKey:@"cartItemCount"]];
                complection(YES,count);
            }
            else{
                
                complection(NO,@"0");

            }
        }
        else{
            
            complection(NO,@"0");
            
        }
    }];
}

@end

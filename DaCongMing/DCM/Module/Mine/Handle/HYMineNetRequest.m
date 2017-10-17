//
//  HYMineNetRequest.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMineNetRequest.h"

@implementation HYMineNetRequest

+ (void)getMyUserInfoComplectionBlock:(void (^)(HYMyUserInfo *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetUserInfo withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                
                HYMyUserInfo *myUserInfo = [HYMyUserInfo sharedInstance];
                [myUserInfo modelSetWithDictionary:dict];
                complection(myUserInfo);
            }
            else{
                complection(nil);
            }
        }
    }];
}

+ (void)getMyCollectGoodsWithPageNo:(NSInteger)PageNo ComplectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:[NSString stringWithFormat:@"%ld",(long)PageNo] forKey:@"pageNo"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetCollectGoods withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *datalist = [returnData objectForKey:@"dataInfo"][@"dataList"];

                complection(datalist);
            }
            else{
                complection(nil);
            }
        }
    }];
}

+ (void)getMyCollectShopWithPageNo:(NSInteger)PageNo ComplectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:[NSString stringWithFormat:@"%ld",(long)PageNo] forKey:@"pageNo"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetCollectShop withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *datalist = [returnData objectForKey:@"dataInfo"][@"dataList"];
                
                complection(datalist);
            }
            else{
                complection(nil);
            }
        }
    }];
}

+ (void)getMySellAfterWithPageNo:(NSInteger)PageNo ComplectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:[NSString stringWithFormat:@"%ld",(long)PageNo] forKey:@"pageNo"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetMySellAfter withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *datalist = [returnData objectForKey:@"dataInfo"][@"dataList"];
                
                complection(datalist);
            }
            else{
                complection(nil);
            }
        }
    }];
}

+ (void)getMyShareWithComplectionBlock:(void (^)(NSDictionary *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_UserShare withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                
                complection(dict);
            }
            else{
                complection(nil);
            }
        }
    }];
}

+ (void)deleteOrderWithOrderID:(NSString *)orderID ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:orderID forKey:@"sorder_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_DeleteOrder withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                complection(NO);
            }
        }
    }];
}

+ (void)submitApplySellAfterWithSellerID:(NSString *)sellerID orderID:(NSString *)orderID itemDetail:(NSString *)itemDetail reason:(NSString *)reason ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:sellerID forKey:@"seller_id"];
    [requestParam setValue:orderID forKey:@"sorder_id"];
    [requestParam setValue:itemDetail forKey:@"itemDtl"];
    [requestParam setValue:reason forKey:@"ref_reason"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SubmitApplySellAfter withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                complection(NO);
            }
        }
    }];
}

+ (void)getRefundDetailWithRefundID:(NSString *)refundID ComplectionBlock:(void (^)(HYRefundModel *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:refundID forKey:@"refundOrder_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetRefundDetail withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"][@"refOrderhdr"];
                HYRefundModel *model = [HYRefundModel modelWithDictionary:dict];
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

@end

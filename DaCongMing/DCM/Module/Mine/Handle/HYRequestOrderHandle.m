//
//  HYRequestOrderHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRequestOrderHandle.h"

@implementation HYRequestOrderHandle

+ (void)requestAllOrderDataWithPageNo:(NSInteger)pageNo andPage:(NSInteger)pageSize ComplectionBlock :(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:@(pageSize) forKey:@"pageSize"];
    [requestParam setValue:@(pageNo) forKey:@"pageNo"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_MyAllOrder withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"dataInfo"][@"dataList"];
                complection(array);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取订单信息出错!"];
            }
        }
    }];
}

+ (void)requestOrderDetailWithOrderID:(NSString *)orderID complectionBlock:(void (^)(HYMyOrderModel *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:orderID forKey:@"sorder_id"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_MyAllOrderDetail withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                HYMyOrderModel *orderModel = [HYMyOrderModel modelWithDictionary:dict];
                complection(orderModel);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取订单信息出错!"];
            }
        }
    }];
}

+ (void)requestOrderDataWithState:(NSInteger)order_state pageNo:(NSInteger)pageNo andPage:(NSInteger)pageSize complectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:@(order_state) forKey:@"order_stat"];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:@(pageSize) forKey:@"pageSize"];
    [requestParam setValue:@(pageNo) forKey:@"pageNo"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_MyOrderByState withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"dataInfo"][@"dataList"];
                complection(array);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取订单信息出错!"];
            }
        }
    }];
}

+ (void)requestDiscountCouponComplectionBlock:(void (^)(NSArray *))complection noDataBlock:(void (^)())noDiscountCoupon{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_MyDiscountConpon withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"dataInfo"][@"userCoupons"];
                if (array.count) {
                    
                    complection(array);
                }
                else{
                   
                    noDiscountCoupon();
                }
                
            }
            else{
                
                noDiscountCoupon();
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取订单信息出错!"];
            }
        }
    }];
}

+ (void)requestReceivedAddressComplectionBlock:(void (^)(NSArray *))complection noDataBlock:(void (^)())noAddressBlock{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_MyReceiverAddress withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"dataInfo"][@"dataList"];
                if (array.count) {
                    
                    complection(array);
                }
                else{
                    
                    noAddressBlock();
                }
                
                
            }
            else{
                
                noAddressBlock();
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取用户收货地址出错"];
            }
        }
    }];
}

+ (void)addReceivedAddress:(NSDictionary *)addressDict ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValuesForKeysWithDictionary:addressDict];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_AddReceiveAddress withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                complection(NO);
            }
        }
    }];
}

+ (void)setDefaultReceivedAddress:(NSString *)newAddress_id oldAddressID:(NSString *)oldAddressID ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:newAddress_id forKey:@"old_dfaddress_id"];
    [requestParam setValue:oldAddressID forKey:@"new_dfaddress_id"];

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_setDefaultReceiveAddress withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
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

+ (void)deleteReceivedAddress:(NSString *)addressID ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:addressID forKey:@"address_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_deleteReceiveAddress withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                complection(NO);
            }
        }
    }];
}

@end

//
//  HYGoodsHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodsHandle.h"

@implementation HYGoodsHandle

+ (void)requestGoodsListItem_type:(NSString *)item_type pageNo:(NSInteger)pageNo andPage:(NSInteger)pageSize order:(NSString *)order hotsale:(NSString *)hotSale complectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(pageNo) forKey:@"pageNo"];
    [param setValue:item_type forKey:@"item_type"];
    [param setValue:@(pageSize) forKey:@"pageSize"];
    [param setValue:order forKey:@"order"];
    [param setValue:hotSale forKey:@"hotsale"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GoodsList withParameter:param isShowHUD:NO success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"dataInfo"][@"dataList"];
                
                complection(array);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取商品列表出错!"];
            }
        }
        
    }];
}

+ (void)requestProductsDetailWithGoodsID:(NSString *)goodsID andToken:(NSString *)token complectionBlock:(void (^)(HYGoodsDetailModel *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:goodsID forKey:@"item_id"];
    [param setValue:token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GoodsDetail withParameter:param isShowHUD:NO success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                HYGoodsDetailModel *model = [HYGoodsDetailModel modelWithDictionary:dict];
                complection(model);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取商品详情出错!"];
            }
        }
        
    }];
}

+ (void)createOrderWithGuid:(NSString *)guid itemID:(NSString *)itemID count:(NSInteger)count sellerID:(NSString *)sellerID andUnit:(NSString *)unit complectionBlock:(void (^)(HYCreateOrder *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (!guid) {
         [param setValue:@"null" forKey:@"guid"];
    }
    else{
        [param setValue:guid forKey:@"guid"];
    }
    [param setValue:itemID forKey:@"item_id"];
    [param setValue:@(count) forKey:@"qty"];
    [param setValue:sellerID forKey:@"seller_id"];
    [param setValue:unit forKey:@"unit"];
    NSArray *arr = @[param];
    NSString *payOrderInfoStr = [arr jsonStringEncoded];
    DLog(@"payOrderInfoStr:%@",payOrderInfoStr);

    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:payOrderInfoStr forKey:@"pay_orderinfo"];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CreateOrder withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                HYCreateOrder *model = [HYCreateOrder modelWithDictionary:dict];
                complection(model);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"订单创建出错!"];
            }
        }
    }];
}

@end

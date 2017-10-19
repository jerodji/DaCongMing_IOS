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
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GoodsList withParameter:param isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"dataInfo"][@"dataList"];
                
                complection(array);
            }
            else{
                
                complection(nil);
                [MBProgressHUD hidePregressHUD:KEYWINDOW];
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取商品列表出错!"];
            }
        }
        
    }];
}

+ (void)requestProductsDetailWithGoodsID:(NSString *)goodsID andToken:(NSString *)token complectionBlock:(void (^)(HYGoodsDetailModel *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:goodsID forKey:@"item_id"];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
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

+ (void)createOrderWithOrderID:(NSString *)orderID complectionBlock:(void (^)(HYCreateOrder *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:orderID forKey:@"sorder_id"];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CreateOrderWithOrderID withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
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

+ (void)changeOrderReceiveAddressOrderID:(NSString *)orderID addressModel:(HYMyAddressModel *)addressModel ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:orderID forKey:@"sorder_ids"];
//    [requestParam setValue:addressModel.province forKey:@"province_name"];
//    [requestParam setValue:addressModel.city forKey:@"city_name"];
//    [requestParam setValue:addressModel.area forKey:@"area_name"];
//    [requestParam setValue:addressModel.address forKey:@"address"];
//    [requestParam setValue:addressModel.receiver forKey:@"receiver"];
    [requestParam setValue:addressModel.address_id forKey:@"address_id"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_ChangeOrderReceiveAddress withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
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

+ (void)addToShoppingCartsItemID:(NSString *)itemID count:(NSInteger)count andUnit:(NSString *)unit ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:itemID forKey:@"item_id"];
    [requestParam setValue:unit forKey:@"unit"];
    [requestParam setValue:[NSNumber numberWithInteger:count] forKey:@"qty"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_AddToShoppingCarts withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
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

+ (void)addToCollectionGoodsWithItemID:(NSString *)itemID ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:itemID forKey:@"item_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_AddToCollectGoods withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
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

+ (void)getBrandsShopWithSellerID:(NSString *)sellerID ComplectionBlock:(void (^)(NSDictionary *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:sellerID forKey:@"seller_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_ShopHomePage withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
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
        else{
            
            complection(nil);
        }
    }];
}

+ (void)collectShopWithSellerID:(NSString *)sellerID ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:sellerID forKey:@"seller_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CollectShop withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
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

+ (void)cancelCollectShopWithSellerIDs:(NSString *)sellerIDs ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:sellerIDs forKey:@"seller_ids"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CancelCollectShop withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"successed"] integerValue];
            if (code == 000) {
                
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

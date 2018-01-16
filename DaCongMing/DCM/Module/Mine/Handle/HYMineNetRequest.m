//
//  HYMineNetRequest.m
//  DaCongMing
//
//

#import "HYMineNetRequest.h"

@implementation HYMineNetRequest

+ (void)getMyUserInfoComplectionBlock:(void (^)(HYMyUserInfo *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetUserInfo withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                
                HYMyUserInfo *myUserInfo = [HYMyUserInfo sharedInstance];
                [myUserInfo modelSetWithDictionary:dict];
                complection(myUserInfo);
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

+ (void)getMyCollectGoodsWithPageNo:(NSInteger)PageNo ComplectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:[NSString stringWithFormat:@"%ld",(long)PageNo] forKey:@"pageNo"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetCollectGoods withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSArray *datalist = [returnData objectForKey:@"data"][@"dataList"];

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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSArray *datalist = [returnData objectForKey:@"data"][@"dataList"];
                
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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSArray *datalist = [returnData objectForKey:@"data"][@"dataList"];
                
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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
                
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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
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
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"][@"refOrderhdr"];
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

+ (void)submitlogisticsInfoWithRefundID:(NSString *)refundID logisticsCompany:(NSString *)company logisticsNum:(NSString *)number ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:refundID forKey:@"refOrderhdr_id"];
    [requestParam setValue:company forKey:@"express_id"];
    [requestParam setValue:number forKey:@"express_no"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SubmitRefundLogisticsInfo withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                complection(NO);
            }
        }
    }];
}

+ (void)deleteMyCollectionGoodsWithItemIDs:(NSString *)itemIDs ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:itemIDs forKey:@"item_ids"];

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_RemoveCollectGoods withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                complection(NO);
            }
        }
    }];
}

+ (void)commentWithOrderID:(NSString *)orderID jsonText:(NSString *)jsonText ComplectionBlock:(void (^)(BOOL))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:orderID forKey:@"sorder_id"];
    [requestParam setValue:jsonText forKey:@"evaluateJSON"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CommentOrder withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                complection(YES);
            }
            else{
                complection(NO);
            }
        }
    }];
}

+ (void)getlogisticsUrlWithOrderID:(NSString *)orderID ComplectionBlock:(void (^)(NSString *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:orderID forKey:@"sorder_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GetLogisticUrl withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSString *url = [returnData objectForKey:@"data"][@"express_url"];
                complection(url);
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

+ (void)getSystemInfoWithPageNo:(NSInteger)pageNo ComplectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [requestParam setValue:@(pageNo) forKey:@"pageNo"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_SystemMessage withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSArray *list = [[returnData objectForKey:@"data"] objectForKey:@"list"];
                complection(list);
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

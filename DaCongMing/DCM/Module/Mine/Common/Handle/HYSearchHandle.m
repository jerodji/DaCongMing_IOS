//
//  HYSearchHandle.m
//  DaCongMing
//
//

#import "HYSearchHandle.h"

@implementation HYSearchHandle

+ (void)searchProductsWithText:(NSString *)text pageNo:(NSInteger)pageNo complectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:text forKey:@"keyWord"];
    [requestParam setValue:@(pageNo) forKey:@"pageNo"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_KeywordsSearch withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"data"][@"dataList"];
                complection(array);
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

+ (void)searchProductsInShop:(NSString *)sellerID WithText:(NSString *)text complectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:text forKey:@"keyWord"];
    [requestParam setValue:@(1) forKey:@"pageNo"];
    [requestParam setValue:sellerID forKey:@"seller_id"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_KeywordsSearch withParameter:requestParam isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code = [[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSArray *array = [returnData objectForKey:@"data"][@"dataList"];
                complection(array);
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

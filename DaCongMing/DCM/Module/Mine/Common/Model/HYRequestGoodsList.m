//
//  HYRequestGoodsList.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRequestGoodsList.h"

@implementation HYRequestGoodsList

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

@end

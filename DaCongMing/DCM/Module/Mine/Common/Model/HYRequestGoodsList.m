//
//  HYRequestGoodsList.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRequestGoodsList.h"

@implementation HYRequestGoodsList

+ (void)requestGoodsListItem_type:(NSString *)item_type pageNo:(NSInteger)pageNo andPage:(NSInteger)pageSize complectionBlock:(void (^)(NSArray *datalist))complection{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(pageNo) forKey:@"pageNo"];
    [param setValue:item_type forKey:@"item_type"];
    [param setValue:@(pageSize) forKey:@"pageSize"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_GoogsList withParameter:param isShowHUD:NO success:^(id returnData) {
       
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

@end

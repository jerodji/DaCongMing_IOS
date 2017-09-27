//
//  HYRequestOrderHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRequestOrderHandle.h"

@implementation HYRequestOrderHandle

+ (void)requestOrderDataWithState:(NSInteger)order_state pageNo:(NSInteger)pageNo andPage:(NSInteger)pageSize complectionBlock:(void (^)(NSArray *))complection{
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionary];
    [requestParam setValue:@(order_state) forKey:@"order_stat"];
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

@end

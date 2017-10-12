//
//  HYMineNetRequest.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMineNetRequest.h"

@implementation HYMineNetRequest

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

@end

//
//  HYHomeViewModel.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeViewModel.h"

@implementation HYHomeViewModel

+ (void)requestHomePageData:(void (^)(HYHomePageModel *))complemtion failureBlock:(void (^)())failure{

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_HomePage withParameter:nil isShowHUD:NO success:^(id returnData) {
       
        if (returnData) {
            
            if ([[returnData objectForKey:@"successed"] integerValue] == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"dataInfo"];
                HYHomePageModel *model = [HYHomePageModel modelWithDictionary:dict];
                complemtion(model);
            }
            else{
                
                complemtion(nil);
            }
        }
        else{
            
            failure();
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"网络出现了问题"];
        }
        
    }];
}

@end

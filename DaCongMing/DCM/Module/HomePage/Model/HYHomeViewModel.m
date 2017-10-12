//
//  HYHomeViewModel.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeViewModel.h"

@implementation HYHomeViewModel

+ (void)requestHomePageData:(void (^)(HYHomePageModel *))complemtion{

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
        
    }];
}

@end

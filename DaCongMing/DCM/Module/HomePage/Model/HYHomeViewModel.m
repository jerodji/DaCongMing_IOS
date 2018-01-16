//
//  HYHomeViewModel.m
//  DaCongMing
//
//

#import "HYHomeViewModel.h"

@implementation HYHomeViewModel

+ (void)requestHomePageData:(void (^)(HYHomePageModel *))complemtion failureBlock:(void (^)())failure{

    [[HTTPManager shareHTTPManager] postDataFromUrl:API_HomePage withParameter:nil isShowHUD:NO success:^(id returnData) {
       
        if (returnData) {
            
            if ([[returnData objectForKey:@"code"] integerValue] == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"];
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

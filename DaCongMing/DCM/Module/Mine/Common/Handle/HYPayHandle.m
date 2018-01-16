//
//  HYPayHandle.m
//  DaCongMing
//
//

#import "HYPayHandle.h"

@implementation HYPayHandle

+ (void)alipayWithOrderID:(NSString *)orderID coupon_guid:(NSString *)coupon_guid buyerMessage:(NSString *)buyerMessage complectionBlock:(void (^)(NSString *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:orderID forKey:@"sorder_ids"];
    [param setValue:@"goods" forKey:@"sell_type"];
    [param setValue:coupon_guid forKey:@"coupon_guid"];
    [param setValue:buyerMessage forKey:@"orderMessage"];

    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Alipay withParameter:param isShowHUD:NO success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSString *sign = [returnData objectForKey:@"orderInfo"];
                
                complection(sign);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取支付签名出错"];
            }
        }
        
    }];
}

+ (void)weChatPayWithOrder:(NSString *)orderID coupon_guid:(NSString *)coupon_guid buyerMessage:(NSString *)buyerMessage complectionBlock:(void (^)(HYWeChatPayModel *))complection{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[HYUserModel sharedInstance].token forKey:@"token"];
    [param setValue:orderID forKey:@"sorder_ids"];
    [param setValue:@"goods" forKey:@"sell_type"];
    [param setValue:coupon_guid forKey:@"coupon_guid"];
    [param setValue:buyerMessage forKey:@"orderMessage"];
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_WeChatPay withParameter:param isShowHUD:NO success:^(id returnData) {
        
        if (returnData) {
            
            NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code == 000) {
                
                NSDictionary *dict = [returnData objectForKey:@"data"][@"orderInfo"];
                HYWeChatPayModel *model = [HYWeChatPayModel modelWithDictionary:dict];
                complection(model);
            }
            else{
                
                complection(nil);
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"获取支付签名出错"];
            }
        }
        
    }];
}

@end

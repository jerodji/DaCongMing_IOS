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

/**
 createAgentBankPayOrder.do
 
 token
 bankCard_id 银行卡号
 bankName 打款银行
 payer_name 打款人姓名
 payer_phoneNum 打款人电话号码
 */
+ (void)unipaymentOfflineWithBank:(NSString*)bank acount:(NSString*)acount name:(NSString*)name pbone:(NSString*)phone complectionBlock:(void (^)(BOOL suc))complection {
    NSDictionary* params = @{
                             @"token":[HYUserModel sharedInstance].token,
                             @"bankName":bank,
                             @"bankCard_id":acount,
                             @"payer_name":name,
                             @"payer_phoneNum":phone
                             };
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_createAgentBankPayOrder withParameter:params isShowHUD:YES success:^(id returnData) {
        if (returnData) {
             NSInteger code =[[returnData objectForKey:@"code"] integerValue];
            if (code==000) {
                complection(YES);
            } else {
                NSString* message = [returnData objectForKey:@"message"];
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:message];
                complection(nil); //test
            }
        }
    }];
    
}

@end

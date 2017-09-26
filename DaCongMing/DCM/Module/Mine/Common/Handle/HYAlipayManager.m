//
//  HYAlipayManager.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAlipayManager.h"

@implementation HYAlipayManager

+ (void)alipayWithOrderString:(NSString *)orderString success:(AlipaySuccessBlock)success failed:(AlipayFailedBlock)failBlock{
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"com.beanu.hailin" callback:^(NSDictionary *resultDic) {
       
        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
            
            success();
        }
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) {
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"订单正在处理中"];
        }
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"订单支付失败"];
            
            failBlock();
        }
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {

            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"用户中途取消"];
        }
        
        if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"网络连接出错"];

        }
    }];
}

@end

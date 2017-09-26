//
//  HYWeChatPayManager.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYWeChatPayManager.h"

@implementation HYWeChatPayManager

+ (void)wechatPayWith:(HYWeChatPayModel *)model{
    
    PayReq *request = [PayReq new];
    
    request.partnerId = model.partnerid;
    request.package = model.package;
    request.nonceStr = model.noncestr;
    request.timeStamp = model.timestamp;
    request.sign = model.sign;
    request.prepayId = model.prepayid;
    [WXApi sendReq:request];
}

@end

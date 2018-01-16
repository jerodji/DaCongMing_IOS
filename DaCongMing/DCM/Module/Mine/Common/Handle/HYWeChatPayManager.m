//
//  HYWeChatPayManager.m
//  DaCongMing
//
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

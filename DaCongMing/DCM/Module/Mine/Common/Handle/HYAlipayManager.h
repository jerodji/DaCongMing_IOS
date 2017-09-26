//
//  HYAlipayManager.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"
#import <AlipaySDK/AlipaySDK.h>

typedef void(^AlipaySuccessBlock)();
typedef void(^AlipayFailedBlock)();

@interface HYAlipayManager : HYBaseModel

+ (void)alipayWithOrderString:(NSString *)orderString success:(AlipaySuccessBlock)success failed:(AlipayFailedBlock)failBlock;

@end

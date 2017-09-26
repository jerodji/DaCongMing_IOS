//
//  HYWeChatPayManager.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"
#import "HYWeChatPayModel.h"

@interface HYWeChatPayManager : HYBaseModel

+ (void)wechatPayWith:(HYWeChatPayModel *)model;

@end

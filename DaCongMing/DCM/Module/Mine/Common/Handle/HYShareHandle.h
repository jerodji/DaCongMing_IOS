//
//  HYShareHandle.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYShareModel.h"

@interface HYShareHandle : NSObject

+ (void)shareToWechatWithModel:(HYShareModel *)shareModel;

@end

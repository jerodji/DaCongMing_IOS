//
//  HYHomeViewModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYHomePageModel.h"

@interface HYHomeViewModel : NSObject

+ (void)requestHomePageData:(void(^)(HYHomePageModel *model))complemtion failureBlock:(void(^)())failure;

@end

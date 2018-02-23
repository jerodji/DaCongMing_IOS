//
//  BannerModel.m
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "JJBannerModel.h"

@implementation JJBannerModel

+ (JJBannerModel*)modelFromDict:(NSDictionary*)dict {
    
    if (IsNull(dict)) {
        return nil;
    }
    
    JJBannerModel* model = [self modelWithDictionary:dict];
    return model;
}

@end

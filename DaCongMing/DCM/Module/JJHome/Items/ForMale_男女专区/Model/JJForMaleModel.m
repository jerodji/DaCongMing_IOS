//
//  JJForMaleModel.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJForMaleModel.h"

@implementation JJForMaleModel

+ (JJForMaleModel *)modelFromDict:(NSDictionary *)dict {
    JJForMaleModel* model = [[JJForMaleModel alloc] init];
    model = [JJForMaleModel modelWithDictionary:dict];
    return model;
}

@end

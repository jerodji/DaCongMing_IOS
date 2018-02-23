//
//  JJProductCategoryModel.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJProductCategoryModel.h"

@implementation JJProductCategoryModel

+ (JJProductCategoryModel*)modelFromDict:(NSDictionary*)dict {
    JJProductCategoryModel* model = [[JJProductCategoryModel alloc] init];
    model = [JJProductCategoryModel modelWithDictionary:dict];
    return model;
}

@end

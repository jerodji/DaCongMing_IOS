//
//  JJNatureModel.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJNatureModel.h"

@implementation JJNatureModel

+ (JJNatureModel *)modelFromDict:(NSDictionary *)dict {
    JJNatureModel* model = [[JJNatureModel alloc] init];
    model = [JJNatureModel modelWithDictionary:dict];
    return model;
}

- (NSString *)img {
    if (_img) return _img;
    return @"";
}

- (NSString *)title {
    if (_title) return _title;
    return @"";
}

- (NSString *)descriptions {
    if (_descriptions) return _descriptions;
    return @"";
}

@end

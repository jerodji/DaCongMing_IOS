//
//  JJCarouselCellModel.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJCarouselCellModel.h"

@implementation JJCarouselCellModel

+ (JJCarouselCellModel *)modelFromDict:(NSDictionary *)dict {
    JJCarouselCellModel* model = [[JJCarouselCellModel alloc] init];
    model = [JJCarouselCellModel modelWithDictionary:dict];
    return model;
}


@end

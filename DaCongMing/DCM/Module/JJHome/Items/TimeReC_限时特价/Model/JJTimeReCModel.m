//
//  JJTimeReCModel.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJTimeReCModel.h"

@implementation JJTimeReCModel

+ (JJTimeReCModel*)modelFromDict:(NSDictionary*)dict {
    JJTimeReCModel* model = [[JJTimeReCModel alloc] init];
    model = [JJTimeReCModel modelWithDictionary:dict];
    return model;
}

/**
 @property (nonatomic, copy) NSString* itemName;
 @property (nonatomic, copy) NSString* originalPrice;
 @property (nonatomic, copy) NSString* price;
 @property (nonatomic, copy) NSString* itemTitleImage;
 @property (nonatomic, copy) NSString* startTime;
 @property (nonatomic, copy) NSString* endTime;
 @property (nonatomic, copy) NSString* publicity;
 @property (nonatomic, copy) NSString* jumpUrl;

 */
- (NSString *)itemName {
    if (_itemName) {
        return _itemName;
    }
    return @" ";
}
- (NSString *)originalPrice {
    if (_originalPrice) {
        return _originalPrice;
    }
    return @"0.0";
}
- (NSString *)price {
    if (_price) {
        return _price;
    }
    return @"0.0";
}
- (NSString *)itemTitleImage {
    if (_itemTitleImage) {
        return _itemTitleImage;
    }
    return @" ";
}
- (NSString *)startTime {
    if (_startTime) {
        return _startTime;
    }
    return @" ";
}
- (NSString *)endTime {
    if (_endTime) {
        return _endTime;
    }
    return @" ";
}
- (NSString *)publicity {
    if (_publicity) {
        return _publicity;
    }
    return @" ";
}



@end

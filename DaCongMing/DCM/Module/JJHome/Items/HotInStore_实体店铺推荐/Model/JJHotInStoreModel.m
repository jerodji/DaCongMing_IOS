//
//  JJHotInStoreModel.m
//  DaCongMing
//
//  Created by hailin on 2018/1/24.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJHotInStoreModel.h"

@implementation JJHotInStoreModel

/**
 @property (nonatomic, copy) NSString* itemName;
 @property (nonatomic, copy) NSString* itemTitleImage;
 @property (nonatomic, copy) NSString* price;
 @property (nonatomic, copy) NSString* jumpUrl;
 */

- (NSString *)itemName {
    if (_itemName) {
        return _itemName;
    }
    return @" ";
}

- (NSString *)itemTitleImage {
    if (_itemTitleImage) {
        return _itemTitleImage;
    }
    return @" ";
}

- (NSString *)price {
    if (_price) {
        return _price;
    }
    return @"0.0";
}

- (NSString *)jumpUrl {
    if (_jumpUrl) {
        return _jumpUrl;
    }
    return @" ";
}

@end

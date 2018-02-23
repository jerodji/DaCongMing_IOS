//
//  JJForMaleModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJForMaleModel : NSObject

@property (nonatomic, copy) NSString* imageUrl;
@property (nonatomic, copy) NSString* jumpUrl;

+ (JJForMaleModel *)modelFromDict:(NSDictionary *)dict;

@end

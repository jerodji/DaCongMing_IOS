//
//  JJProductCategoryModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJProductCategoryModel : NSObject
+ (JJProductCategoryModel*)modelFromDict:(NSDictionary*)dict;
//imageUrl
@property (nonatomic, copy) NSString* imageUrl;
//jumpUrl
@property (nonatomic, copy) NSString* jumpUrl;
@end

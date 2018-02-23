//
//  BannerModel.h
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJTableModel.h"

@interface JJBannerModel : JJTableModel

@property (nonatomic,copy) NSString* imageUrl;
@property (nonatomic,copy) NSString* jumpUrl;

+ (JJBannerModel*)modelFromDict:(NSDictionary*)dict;

@end

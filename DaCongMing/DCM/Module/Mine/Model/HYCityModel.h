//
//  HYCityModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCityModel : NSObject

@property(nonatomic, copy) NSString *cityID;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *fatherID;
@property (nonatomic,copy) NSArray *areas;

@end

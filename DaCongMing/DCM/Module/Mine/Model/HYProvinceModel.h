//
//  HYProvinceModel.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/9.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYProvinceModel : NSObject <NSCoding>

@property(nonatomic,copy) NSString *province;
@property(nonatomic,copy) NSString *provinceID;
@property (nonatomic, copy) NSArray *cities;

@end

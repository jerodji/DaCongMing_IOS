//
//  HYProvinceModel.m
//  DaCongMing
//
//

#import "HYProvinceModel.h"

@implementation HYProvinceModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.provinceID forKey:@"provinceID"];
    [aCoder encodeObject:self.cities forKey:@"cities"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.provinceID = [aDecoder decodeObjectForKey:@"provinceID"];
        self.cities = [aDecoder decodeObjectForKey:@"cities"];
    }
    return self;
}

@end

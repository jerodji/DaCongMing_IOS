//
//  HYProvinceModel.h
//  DaCongMing
//
//

#import <Foundation/Foundation.h>

@interface HYProvinceModel : NSObject <NSCoding>

@property(nonatomic,copy) NSString *province;
@property(nonatomic,copy) NSString *provinceID;
@property (nonatomic, copy) NSArray *cities;

@end

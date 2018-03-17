
//
//  HYMyUserInfo.m
//  DaCongMing
//
//

#import "HYMyUserInfo.h"

@implementation HYMyUserInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:nameStr];
            [self setValue:value forKey:nameStr];
        }
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        id  value = [self valueForKey:nameStr];
        [aCoder encodeObject:value forKey:nameStr];
    }
    
    free(ivars);
}

+ (instancetype)sharedInstance{
    
    static HYMyUserInfo *myUserInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        myUserInfo = [[HYMyUserInfo alloc] init];
        
    });
    
    return myUserInfo;
}

- (void)clearData{
    
    //利用runtime清空model中所有的数据
    unsigned count = 0;
    // 获取注册类的属性列表，第一个参数是类，第二个参数是接收类属性数目的变量
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        objc_property_t propertyValue = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(propertyValue) encoding:NSUTF8StringEncoding];
        [self setValue:nil forKey:propertyName];
    }
}


/** V0没有权限(普通客户) V1普通客户 V2实习经销商 V3高级经销商 V4实习合伙人 V5高级合伙人 V6特约合伙人 */

+ (NSString*)getUserStatusWithLevel:(NSString*)level {
    
    if ([level isEqualToString:@"V2"]) {return @"实习经销商";}
    if ([level isEqualToString:@"V3"]) {return @"高级经销商";}
    if ([level isEqualToString:@"V4"]) {return @"实习合伙人";}
    if ([level isEqualToString:@"V5"]) {return @"高级合伙人";}
    if ([level isEqualToString:@"V6"]) {return @"特约合伙人";}
    
    return @"普通客户";
}

@end

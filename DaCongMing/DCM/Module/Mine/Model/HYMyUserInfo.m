
//
//  HYMyUserInfo.m
//  DaCongMing
//
//

#import "HYMyUserInfo.h"

@implementation HYMyUserInfo

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

@end

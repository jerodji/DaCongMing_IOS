
//
//  HYHomePageModel.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomePageModel.h"


@implementation HYTypeReCommend

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

@end

@implementation HYDisCount

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

@end

@implementation HYHomeMenuTitle

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

@end

@implementation HYHomePageModel

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

@end



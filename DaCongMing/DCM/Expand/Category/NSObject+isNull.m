//
//  NSObject+Null.m
//  UnicornTV
//
//  Created by JerodJi on 2017/12/4.
//  Copyright © 2017年 Droi. All rights reserved.
//

/**
 "==" 是判断两个对象的引用（reference）是否一样，也就是内存地址是否一样。
 "isEqualTo" 判断是一个类方法，判断2个对象在类型和值上是否一样。
 
 因为使用[NSNull null]产生的实例都的内存地址都一样，所以可以使用"=="。
 */
/**
 nil：指向一个对象的空指针
 Nil：指向一个类的空指针
 NULL：指向其他类型（如：基本类型、C类型）的空指针
 NSNull：通常表示集合中的空值
 
 */

#import "NSObject+isNull.h"

@implementation NSObject (isNull)

BOOL IsNull(id obj) {
    return [NSObject isNull:obj];
}
BOOL NotNull(id obj) {
    return [NSObject notNull:obj];
}

BOOL IsFullSpace(NSString* str) {
    return [NSObject isFullSpace:str];
}
BOOL NotFullSpace(NSString* str) {
    return [NSObject notFullSpace:str];
}

BOOL IsNullOrIsFullSpace(NSString* obj) {
    if (IsNull(obj) || IsFullSpace(obj) ) {
        return YES;
    } else {
        return NO;
    }
}

BOOL NotNullAndNotFullSpace(NSString* obj) {
    return !IsNullOrIsFullSpace(obj);
}

+ (BOOL)isNull:(id)objc
{
    if (nil==objc || [objc isEqual:[NSNull null]] || [objc isEqual:@"<null>"] || [objc isEqual:@"null"] || [objc isEqual:@"(null)"] ||  objc==Nil || objc==NULL || [objc isEqual:@"<nil>"])
    {
        return YES;
    }
    else
    {
        if ([self isEmpty:objc]) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (BOOL)notNull:(id)objc
{
    return ![self isNull:objc];
}

+ (BOOL)isEmpty:(id)objc
{
    if ([objc isKindOfClass:[NSString class]]) {
        NSString* str = (NSString*)objc;
        if (str.length == 0) {
            return YES;
        }
    }
    
    if ([objc isKindOfClass:[NSArray class]]) {
        NSArray* array = (NSArray*)objc;
        if (array.count == 0) {
            return YES;
        }
    }
    
    if ([objc isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dic = (NSDictionary*)objc;
        if (dic.count == 0) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)notFullSpace:(NSString*)str {
    return ![self isFullSpace:str];
}
+ (BOOL)isFullSpace:(NSString *)str {
    
    if(!str) {
        return YES;
    }else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and next line characters (U+000A–U+000D,U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if([trimedString length] == 0) {
            return YES;
        }else {
            return NO;
        }
    }
}

@end

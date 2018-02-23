//
//  NSArray+crossLine.m
//  DaCongMing
//
//  Created by hailin on 2018/1/20.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "NSArray+crossLine.h"

@implementation NSArray (crossLine)

+ (void)load {
    [super load];
    Method safeMd = class_getClassMethod([NSArray class], @selector(safe_objectAtIndex:));
    Method Md = class_getClassMethod([NSArray class], @selector(objectForKey:));
    method_exchangeImplementations(Md, safeMd);
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (self.count <= index) {
        NSLog(@"数组越界!");
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

@end

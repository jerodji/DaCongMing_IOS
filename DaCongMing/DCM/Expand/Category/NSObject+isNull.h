//
//  NSObject+Null.h
//  UnicornTV
//
//  Created by JerodJi on 2017/12/4.
//  Copyright © 2017年 Droi. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSObject (isNull)

BOOL IsNull(id obj);
BOOL NotNull(id obj);

BOOL IsFullSpace(NSString* str);
BOOL NotFullSpace(NSString* str);

BOOL IsNullOrIsFullSpace(NSString* obj);
BOOL NotNullAndNotFullSpace(NSString* obj);



//+ (BOOL)isNull:(id)objc;
//+ (BOOL)notNull:(id)objc;
//+ (BOOL)isEmpty:(id)objc;

@end

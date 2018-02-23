//
//  UIButton+parameter.m
//  category
//
//  Created by Jerod on 2018/1/11.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "UIButton+parameter.h"
#import <objc/runtime.h>

static NSString * ARGUMENTKEY = @"ARGUMENTKEY";
static NSString * PARAMKEY = @"PARAMKEY";

@implementation UIButton (parameter)

/**
 arguments
 */
- (id)arguments {
    return objc_getAssociatedObject(self, &ARGUMENTKEY);
}

- (void)setArguments:(id)arguments {
    objc_setAssociatedObject(self, &ARGUMENTKEY, arguments, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 params
 */
- (NSMutableDictionary *)params {
    NSMutableDictionary * _params = objc_getAssociatedObject(self, &PARAMKEY);
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &PARAMKEY, _params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _params;
}

- (void)setParams:(NSMutableDictionary *)params {
    objc_setAssociatedObject(self, &PARAMKEY, params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

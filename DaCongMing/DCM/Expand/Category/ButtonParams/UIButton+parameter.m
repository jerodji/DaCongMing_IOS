//
//  UIButton+parameter.m
//  category添加属性
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
//getter
- (id)arguments {
    return objc_getAssociatedObject(self, &ARGUMENTKEY);
}
//setter
- (void)setArguments:(id)arguments {
    objc_setAssociatedObject(self, &ARGUMENTKEY, arguments, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 params
 Associated Objects的key要求是唯一并且是常量，而SEL是满足这个要求的，所以也可以采用隐藏参数_cmd作为key。
 或者  &PARAMKEY 可以换为 @selector(params) 作为参数
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

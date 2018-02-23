//
//  UIView+loadXIB.m
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 胡勇. All rights reserved.
//

#import "UIView+loadXIB.h"

@implementation UIView (loadXIB)
+ (instancetype)loadXIB {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
@end

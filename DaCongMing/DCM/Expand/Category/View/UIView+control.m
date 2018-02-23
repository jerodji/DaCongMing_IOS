//
//  UIView+control.m
//  MVC
//
//  Created by Jerod on 2018/1/15.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "UIView+control.h"

@implementation UIView (control)

- (UIViewController *)viewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

- (UINavigationController *)navigationController {
    return self.viewController.navigationController;
}

@end

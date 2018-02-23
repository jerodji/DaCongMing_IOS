//
//  JJAlert.h
//  UnicornTV
//
//  Created by JerodJi on 2017/11/23.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJAlert : NSObject
+ (void)showAlertWithVC:(UIViewController*)vc message:(NSString*)message cancleAction:(void(^)())_cancle sureAction:(void(^)())_sure;
@end

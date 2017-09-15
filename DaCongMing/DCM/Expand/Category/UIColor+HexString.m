//
//  UIColor+HexString.m
//  ToolsMethod
//
//  Created by LEMO on 2017/2/21.
//  Copyright © 2017年 hy. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)colorString{
    
    //去掉字符串两端的空格和回车
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    //判断colorString的位数
    if ([cString length] < 6) {
        return [UIColor whiteColor];
    }
    else if ([cString hasPrefix:@"#"]){
       cString = [cString substringFromIndex:1];
    }
    else if ([cString length] != 6){
        return [UIColor whiteColor];
    }
    NSRange range;
    range.length = 2;
    range.location = 0;
    
    NSString *RString = [cString substringWithRange:range];
    range.location = 2;
    
    NSString *GString = [cString substringWithRange:range];
    range.location = 4;
    
    NSString *BString = [cString substringWithRange:range];
    
    unsigned int r,g,b;
    //为从一个十六进制表示的无符号值扫描，发现返回参考价值
    [[NSScanner scannerWithString:RString]scanHexInt:&r];
    [[NSScanner scannerWithString:GString]scanHexInt:&g];
    [[NSScanner scannerWithString:BString]scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];

}

@end

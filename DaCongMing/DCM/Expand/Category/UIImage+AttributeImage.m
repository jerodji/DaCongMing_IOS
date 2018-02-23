//
//  UIImage+AttributeImage.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "UIImage+AttributeImage.h"

@implementation UIImage (AttributeImage)

- (UIImage*)setImageBackgroundColor:(UIColor*)color
{
    // 画背景
        CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self drawInRect:rect];
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextFillRect(context, rect);
        
        UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
}

// 合成图片
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image2  哪个图片在最下面先画谁，在这里有先后顺序
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

+ (UIImage *)createImageWith:(UIImage *)image Size:(CGSize)size string:(NSString*)level textColor:(UIColor *)textcolor
{
//    UIImage *image = [[UIImage alloc] init];
    //    CGSize size= CGSizeMake (size.width, size.height); // 画布大小
    UIGraphicsBeginImageContextWithOptions (size, NO, 0.0);
    [image drawAtPoint:CGPointMake(0, 0)];
    
    // 获得一个位图图形上下文
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextDrawPath (context, kCGPathStroke);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    //    level = @"8"; //test
    [level drawInRect:CGRectMake(1, 2, size.width, size.height)
     //CGRectMake(image.size.width / 2, 14, image.size.width / 2, image.size.height)
       withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:8], //[UIFont fontWithName : @"Arial-BoldMT" size:20],
                        NSForegroundColorAttributeName:textcolor,
                        NSParagraphStyleAttributeName: style}];
    
    // 返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    return newImage;
}


/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

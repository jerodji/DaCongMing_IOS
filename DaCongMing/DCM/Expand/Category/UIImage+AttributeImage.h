//
//  UIImage+AttributeImage.h
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AttributeImage)

- (UIImage *)setImageBackgroundColor:(UIColor*)color;

// 合成图片
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

//+ (UIImage *)createImageWithSize:(CGSize)size string:(NSString*)level textColor:(UIColor *)textcolor;
+ (UIImage *)createImageWith:(UIImage *)image Size:(CGSize)size string:(NSString*)level textColor:(UIColor *)textcolor;

/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 原始图片
 *  @param size  目标大小
 *
 *  @return 生成图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

//UIImageJPEGRepresentation(img, 0)

@end

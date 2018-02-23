//
//  UIView+layerSet.h
//  DaCongMing
//
//  Created by hailin on 2018/1/24.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (layerSet)

- (void)layerShadowWithColor:(UIColor*)color Radius:(CGFloat)radius Opacity:(float)opacity Offset:(CGSize)offset Path:(CGPathRef)path;

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)layerCorners:(UIRectCorner)corners withRadiiSize:(CGSize)radii viewRect:(CGRect)rect;

@end

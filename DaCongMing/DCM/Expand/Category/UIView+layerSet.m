//
//  UIView+layerSet.m
//  DaCongMing
//
//  Created by hailin on 2018/1/24.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "UIView+layerSet.h"

@implementation UIView (layerSet)

- (void)layerShadowWithColor:(UIColor*)color Radius:(CGFloat)radius Opacity:(float)opacity Offset:(CGSize)offset Path:(CGPathRef)path {
    self.layer.shadowRadius = radius;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowPath = path;
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)layerCorners:(UIRectCorner)corners withRadiiSize:(CGSize)radii viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}


@end

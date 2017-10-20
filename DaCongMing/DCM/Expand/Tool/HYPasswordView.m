//
//  HYPasswordView.m
//  FlowerHan
//
//  Created by Jackhu on 2017/5/10.
//  Copyright © 2017年 Jackhu. All rights reserved.
//

#define PasswordNum     6

#import "HYPasswordView.h"

@implementation HYPasswordView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self becomeFirstResponder];
        self.backgroundColor = [UIColor whiteColor];
        self.passwordString = [NSMutableString string];
        self.passwordNum = 6;
        //self.squareWidth = (KSCREEN_WIDTH - 80 * WIDTH_MULTIPLE) / _passwordNum;
        self.dotRadius = 6;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

    [super drawRect:rect];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    self.squareWidth = height;
    CGFloat margin = (width - height * 6) / 5;
    
    CGFloat x = (width - self.passwordNum * self.squareWidth) / 2;
    CGFloat y = (height - self.squareWidth) / 2;
    //画外框
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddRect(context, CGRectMake(x, y, self.passwordNum * self.squareWidth, self.squareWidth));
    CGContextAddRect(context, CGRectMake(0, 0, self.width, self.height));
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    //画竖线
//    for (NSInteger i = 0; i < self.passwordNum; i ++) {
//
//        CGContextMoveToPoint(context, x + i * self.squareWidth, y);
//        CGContextAddLineToPoint(context, x + i * self.squareWidth, y + self.squareWidth);
//        CGContextClosePath(context);
//    }
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextSetFillColorWithColor(context, KAPP_7b7b7b_COLOR.CGColor);
    
    //画小黑点
    for (NSInteger i = 0; i < self.passwordString.length; i++) {
        
        CGFloat dotX = x + i * self.squareWidth + self.squareWidth / 2;
        CGFloat dotY = y + (self.squareWidth - self.dotRadius) / 2;
        CGContextAddArc(context, dotX , dotY , self.dotRadius, 0, M_PI * 2, YES);
        CGContextDrawPath(context, kCGPathFill);
    }

}

#pragma mark ********UIKeyInputDelegate********
- (UIKeyboardType)keyboardType{
    
    return UIKeyboardTypeNumberPad;
}

- (BOOL)canBecomeFirstResponder{
    
    return YES;
}

- (BOOL)becomeFirstResponder{
    
    if (_delegate && [_delegate respondsToSelector:@selector(passwordBeginInput:)]) {
        
        [_delegate passwordBeginInput:self];
    }
    return [super becomeFirstResponder];
}


//用于显示文本对象是否有文本
- (BOOL)hasText{
    
    return self.passwordString.length > 0;
}

//插入文本
- (void)insertText:(NSString *)text{

    if (self.passwordString.length < self.passwordNum) {
        //判断是否为数字
        NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filterStr = [[text componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        if ([text isEqualToString:filterStr]) {
            
            [self.passwordString appendString:text];
            
            if (_delegate && [_delegate respondsToSelector:@selector(passwordDidChange:)]) {
                
                [_delegate passwordDidChange:self];
            }
            
            [self setNeedsDisplay];
        }
        
    }
    
    if (self.passwordString.length == self.passwordNum) {
        //输入完成
        if (_delegate && [_delegate respondsToSelector:@selector(passwordCompleteInput:)]) {
            
            [_delegate passwordCompleteInput:self];
        }
        [self resignFirstResponder];
    }
}

//删除文本
- (void)deleteBackward{

    if (self.passwordString.length > 0) {
        
        [self.passwordString deleteCharactersInRange:NSMakeRange(self.passwordString.length - 1, 1)];
        if (_delegate && [_delegate respondsToSelector:@selector(passwordDidChange:)]) {
            
            [_delegate passwordDidChange:self];
        }
        
    }
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (![self isFirstResponder]) {
        
        [self becomeFirstResponder];
    }
    
}

@end

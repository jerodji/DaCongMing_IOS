//
//  HYPasswordView.h
//  FlowerHan
//
//  Created by Jackhu on 2017/5/10.
//  Copyright © 2017年 Jackhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYPasswordView ;

@protocol HYPasswordViewDelegate <NSObject>

@optional
/** 
 *    监听输入的改变
 */
- (void)passwordDidChange:(HYPasswordView *)passwordView;

/**
 *    监听输入完成
 */
- (void)passwordCompleteInput:(HYPasswordView *)passwordView;

/**
 *    监听开始输入
 */
- (void)passwordBeginInput:(HYPasswordView *)passwordView;


@end

@interface HYPasswordView : UIView <UIKeyInput>

/** 密码位数 */
@property (nonatomic,assign) NSInteger passwordNum;

/** 密码框的宽度 */
@property (nonatomic,assign) CGFloat squareWidth;

/** 原点半径 */
@property (nonatomic,assign) CGFloat dotRadius;

/** 存放密码的字符串 */
@property (nonatomic,strong) NSMutableString *passwordString;

/**delegate*/
@property (nonatomic,weak) id<HYPasswordViewDelegate>delegate;

@end

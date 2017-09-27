//
//  HYMyOrderTitleView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyOrderTitleChangedDelegate <NSObject>

- (void)titleChanged:(NSInteger)index;

@end

@interface HYMyOrderTitleView : UIView

/** 记录上一次点击的index */
@property (nonatomic,assign) NSInteger previousSelectIndex;
/** delegate */
@property (nonatomic,weak) id<MyOrderTitleChangedDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame WithTitleArray:(NSArray *)titleArray;

@end

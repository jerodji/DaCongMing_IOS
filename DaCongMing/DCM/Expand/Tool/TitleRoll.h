//
//  TitleRoll.h
//  TitleRoll
//
//  Created by Jackhu on 2017/2/27.
//  Copyright © 2017年 Jackhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleRoll : UIView

/**文字滚动的方向*/
@property (nonatomic,assign) NSInteger rollDirection;

/** 设置文本滚动的数组及duration */
- (void)setStringArray:(NSArray *)array rollDuration:(CGFloat )seconds;

@end

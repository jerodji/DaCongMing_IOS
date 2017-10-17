//
//  HYHotSearchView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYHotSearchBtnActionDelegate <NSObject>

- (void)hotSearchBtnTapWithText:(NSString *)text;

@end

@interface HYHotSearchView : UIView

/** delegate */
@property (nonatomic,weak) id<HYHotSearchBtnActionDelegate> delegate;

@end

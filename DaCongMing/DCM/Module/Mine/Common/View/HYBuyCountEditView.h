//
//  HYBuyCountEditView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^countCallbackBlock)(NSInteger count);

@interface HYBuyCountEditView : UIView

/** 回调数量 */
@property (nonatomic,copy) countCallbackBlock countCallback;

@end

//
//  HYCartsBottomView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^checkAllActionBlock)(BOOL isCheckAll);

@interface HYCartsBottomView : UIView

/** 是否全选 */
@property (nonatomic,copy) checkAllActionBlock checkAllBlock;

/** 价格 */
@property (nonatomic,copy) NSString *amount;

@end

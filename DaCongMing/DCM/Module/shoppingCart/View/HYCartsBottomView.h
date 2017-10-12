//
//  HYCartsBottomView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^checkAllActionBlock)(BOOL isCheckAll);

typedef void(^payActionBlock)(CGFloat amount);

@interface HYCartsBottomView : UIView

/** 是否全选 */
@property (nonatomic,copy) checkAllActionBlock checkAllBlock;

/** 结算 */
@property (nonatomic,copy) payActionBlock payAction;

/** checkAllBtn */
@property (nonatomic,strong) HYButton *checkAllBtn;

/** 价格 */
@property (nonatomic,copy) NSString *amount;

@end

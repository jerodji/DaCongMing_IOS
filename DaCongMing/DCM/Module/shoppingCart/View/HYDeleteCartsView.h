//
//  HYDeleteCartsView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/17.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^deleteViewcheckAllActionBlock)(BOOL isCheckAll);

typedef void(^deleteActionBlock)();

@interface HYDeleteCartsView : UIView

/** checkAllBtn */
@property (nonatomic,strong) HYButton *checkAllBtn;

/** 是否全选 */
@property (nonatomic,copy) deleteViewcheckAllActionBlock deleteCheckAllBlock;

/** 删除 */
@property (nonatomic,copy) deleteActionBlock deleteBlock;

@end

//
//  HYCompleteView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SkipBlock)();
typedef void(^ConfirmBlock)(NSString *phone);

@interface HYCompleteView : UIView

/** skipBtn */
@property (nonatomic,strong) UIButton *skipBtn;

/** skipBlock */
@property (nonatomic,copy) SkipBlock skipBlock;
/** confirmBlock */
@property (nonatomic,copy) ConfirmBlock confirmBlock;


@end

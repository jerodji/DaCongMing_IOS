//
//  HYMineHeaderView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYMineHeaderTapDelegate <NSObject>

- (void)headerBtnTapIndex:(NSInteger)index;

@end

@interface HYMineHeaderView : UIView

/** user */
@property (nonatomic,strong) HYUserModel *user;
/** delegate */
@property (nonatomic,weak) id<HYMineHeaderTapDelegate>delegate;

@end

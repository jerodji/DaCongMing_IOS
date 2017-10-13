//
//  HYMineHeaderView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMyUserInfo.h"

@protocol HYMineHeaderTapDelegate <NSObject>

- (void)headerBtnTapIndex:(NSInteger)index;

@end

@interface HYMineHeaderView : UIView

/** user */
@property (nonatomic,strong) HYUserModel *user;
/** 收藏信息 */
@property (nonatomic,strong) HYMyUserInfo *myUserInfo;
/** delegate */
@property (nonatomic,weak) id<HYMineHeaderTapDelegate>delegate;

@end

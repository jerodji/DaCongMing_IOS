//
//  HYMineInfoTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYMineInfoBtnActionDelegate <NSObject>

- (void)jumpToMineInfoDetailVCWithTag:(NSInteger)tag;

@end


@interface HYMineInfoTableViewCell : UITableViewCell

/** delegate */
@property (nonatomic,weak) id<HYMineInfoBtnActionDelegate>delegate;

@end

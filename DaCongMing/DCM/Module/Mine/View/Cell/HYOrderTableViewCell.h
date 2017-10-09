//
//  HYOrderTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myAllOrderBlock)(void);

@protocol HYMyOrderActionDelegate <NSObject>

- (void)jumpToMyOrderDetailVCWithTag:(NSInteger)tag;

@end

@interface HYOrderTableViewCell : UITableViewCell

/** myAllOrderBlock */
@property (nonatomic,copy) myAllOrderBlock myAllOrder;
/** delegate */
@property (nonatomic,weak) id<HYMyOrderActionDelegate> delegate;

@end

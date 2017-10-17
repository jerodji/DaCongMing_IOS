//
//  HYFillSalesReturnCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HYFillSalesReturnDelegate <NSObject>

//回传输入信息
- (void)fillSalesReturnInoInput:(NSString *)count andReason:(NSString *)reason;

@end

@interface HYFillSalesReturnCell : UITableViewCell

/** 价格 */
@property (nonatomic,strong) NSString *price;

/** delegate */
@property (nonatomic,weak) id<HYFillSalesReturnDelegate> delegate;

@end

//
//  HYConfirmSuccessCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LookOrderBlock)();
typedef void(^CommentBlock)();

@interface HYConfirmSuccessCell : UITableViewCell

/** 查看订单 */
@property (nonatomic,copy) LookOrderBlock lookOrderBlock;
/** 评价 */
@property (nonatomic,copy) CommentBlock commentBlock;

@end

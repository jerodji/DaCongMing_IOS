//
//  HYCommentTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMyOrderModel.h"

@protocol HYCommentProductsDelegate <NSObject>

- (void)commentWithText:(NSString *)text andScore:(CGFloat)score WithIndexPath:(NSIndexPath *)indexPath;

@end

@interface HYCommentTableViewCell : UITableViewCell

/** 订单商品信息model */
@property (nonatomic,strong) HYMyOrderDetailsModel *orderDetailModel;
/** indexPath */
@property (nonatomic,strong) NSIndexPath *indexPath;
/** delegate */
@property (nonatomic,weak) id<HYCommentProductsDelegate>delegate;

@end

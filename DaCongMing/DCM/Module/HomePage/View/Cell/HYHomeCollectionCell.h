//
//  HYHomeCollectionCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYHomePageModel.h"

typedef void(^SelectItemBlock)(NSString *itemType);

@interface HYHomeCollectionCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYHomePageModel *model;
/** 点击brands回调 */
@property (nonatomic,copy) SelectItemBlock selectItemBlock;

@end

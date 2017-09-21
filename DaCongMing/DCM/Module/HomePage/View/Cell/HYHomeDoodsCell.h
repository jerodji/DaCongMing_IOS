//
//  HYHomeDoodsCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^collectionSelectBlock)(NSString *productID);

@interface HYHomeDoodsCell : UITableViewCell

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;

/** 点击collectionBlock */
@property (nonatomic,copy) collectionSelectBlock collectionSelect;

@end

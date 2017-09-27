//
//  HYHomeImgScrollCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGoodHealthModel.h"

typedef void(^collectionSelectBlock)(NSString *productID);

@interface HYHomeImgScrollCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYGoodHealthModel *goodHealthModel;

/** 点击collectionBlock */
@property (nonatomic,copy) collectionSelectBlock collectionSelect;

/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;

@end

//
//  HYHomeCollectionViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYReCommendTday.h"
#import "HYItemListModel.h"

@interface HYHomeCollectionViewCell : UICollectionViewCell

/** model */
@property (nonatomic,strong) HYReCommendTday *commendTodayModel;

/** 健康养生 itemList */
@property (nonatomic,strong) HYItemListModel *itemListModel;

@end

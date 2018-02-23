//
//  JJTimeReCCell.h
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTimeReCModel.h"

@class JJTimeReCCell;
@protocol TimeReCUpdateTimeListener<NSObject>
- (void)updateTimeForCell:(JJTimeReCCell*)cell model:(JJTimeReCModel*)model;
@end

@interface JJTimeReCCell : UICollectionViewCell
//@interface JJTimeReCCell : UIView

@property (nonatomic, strong) JJTimeReCModel* model;
- (instancetype)initWithFrame:(CGRect)frame;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicityLabel; /* 说明/剩余时间 */
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UIImageView *activImg;

@property (nonatomic,weak) id<TimeReCUpdateTimeListener> delegate;

@end


 /**
 {
 "itemName": "静心养神 健康 纯天然 艾草线香",
 "originalPrice": "390.0",
 "itemTitleImage": "http://pic.laopdr.cn:80/item_image/3f1607f37de04206acea854ed01e4e78.jpg",
 "publicity": "安心定神，杀菌去味",
 "jumpUrl": "http://www.laopdr.cn/app/itemDetail?id=HL0139",
 "itemMinPrice": "800.0",
  "startTime": "2018-01-24 00:00:00.0",
  "endTime": "2018-05-01 00:00:00.0",
 }
 */


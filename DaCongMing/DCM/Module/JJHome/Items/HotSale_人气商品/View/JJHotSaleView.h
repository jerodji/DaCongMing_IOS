//
//  JJHotSaleView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCarouselCell.h"

@interface JJHotSaleView : UIView
@property (nonatomic, strong) NSMutableArray<JJCarouselCellModel*>* modelArray;
- (void)updateUI;
@end

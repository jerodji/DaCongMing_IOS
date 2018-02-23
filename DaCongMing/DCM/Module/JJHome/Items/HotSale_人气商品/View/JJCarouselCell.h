//
//  JJCarouselCell.h
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCarouselCellModel.h"

typedef void(^ADD_CART_BLK)(void);
//typedef void(^CLICK_ITEM_BLK)(void);

@interface JJCarouselCell : UIView

@property (nonatomic, strong) JJCarouselCellModel* model;

@property (nonatomic, copy) ADD_CART_BLK addCartCB;
//@property (nonatomic, copy) CLICK_ITEM_BLK clickItemCB;

@end

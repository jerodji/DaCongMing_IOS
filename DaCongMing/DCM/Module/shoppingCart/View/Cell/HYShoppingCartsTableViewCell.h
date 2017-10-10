//
//  HYShoppingCartsTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCartsModel.h"

@interface HYShoppingCartsTableViewCell : UITableViewCell

/** 商家model */
@property (nonatomic,strong) HYCartsSeller *cartsSeller;

@end

//
//  HYAddressTableViewCell.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYMyAddressModel.h"

@protocol HYAddressBtnActionDelegate <NSObject>

- (void)addressBtnAcitonWithFlag:(NSInteger)flag indexPath:(NSIndexPath *)indexPath;

@end

@interface HYAddressTableViewCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYMyAddressModel *addressModel;

/** delegate */
@property (nonatomic,weak) id<HYAddressBtnActionDelegate>delegate;

/** indexPath */
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

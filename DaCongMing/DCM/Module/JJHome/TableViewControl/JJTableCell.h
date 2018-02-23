//
//  JJTableCell.h
//  DaCongMing
//
//  Created by hailin on 2018/1/20.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTitleView.h"
#import "JJTableModel.h"
@interface JJTableCell : UITableViewCell

@property (nonatomic, strong) JJTableModel* model;

- (void)viewWillAppear;

@end

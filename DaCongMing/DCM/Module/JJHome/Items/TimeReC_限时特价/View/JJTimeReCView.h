//
//  JJTimeReCView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTimeReCCell.h"

@interface JJTimeReCView : UIView
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray*)dataArr;
- (void)updateUI;
- (void)viewWillAppear;
@end

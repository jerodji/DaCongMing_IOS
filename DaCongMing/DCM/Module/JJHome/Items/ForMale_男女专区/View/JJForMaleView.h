//
//  JJForMaleView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJForMaleModel.h"

@interface JJForMaleView : UIView
@property (nonatomic, strong) NSMutableArray<JJForMaleModel*>* modelArray;
- (void)updateUI;
@end

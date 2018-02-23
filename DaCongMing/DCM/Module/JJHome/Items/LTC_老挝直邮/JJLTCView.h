//
//  JJLTCView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJLTCModel.h"

@interface JJLTCView : UIView
@property (nonatomic, strong) UIImageView* imgView;
- (void)updateUIWith:(NSDictionary*)ltcDict;
@end

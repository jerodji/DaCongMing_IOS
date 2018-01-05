//
//  HYShareView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYShareModel.h"


@interface HYShareView : UIView

@property (nonatomic,strong) HYShareModel *shareModel;

- (void)showShareView;

@end

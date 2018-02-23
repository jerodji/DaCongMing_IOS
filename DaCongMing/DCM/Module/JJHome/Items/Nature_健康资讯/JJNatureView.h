//
//  JJNatureView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJNatureCell.h"

@interface JJNatureView : UIView
@property (nonatomic, strong) NSMutableArray<JJNatureModel*>* modelArray;
- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSMutableArray*)dataArray;
@end

//
//  JJProductCategoryView.h
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJProductCategoryModel.h"

@interface JJProductCategoryView : UIView
@property (nonatomic, strong) NSMutableArray<JJProductCategoryModel*>* block; //data source array
- (instancetype)initWithFrame:(CGRect)frame;
- (void)updateUI;
@end

//
//  JJTitleController.h
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJTitleView.h"
#import "JJTitleModel.h"
//#import "JJProductCategoryController.h"




@interface JJTitleController : NSObject

@property (nonatomic, strong) JJTitleView * view;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)fetchData;

@end

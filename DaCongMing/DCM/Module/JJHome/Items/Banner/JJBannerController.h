//
//  BannerController.h
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJBannerView.h"
#import "JJBannerModel.h"

@interface JJBannerController : NSObject
- (instancetype)initWithFrame:(CGRect)frame;
- (void)configModelWith:(NSArray*)arr;
@property (nonatomic, strong) JJBannerView* view;
//@property (nonatomic, strong) NSMutableArray* modelArray;
@end

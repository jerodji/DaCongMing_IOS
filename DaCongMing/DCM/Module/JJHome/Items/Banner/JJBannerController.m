//
//  BannerController.m
//  DaCongMing
//
//  Created by hailin on 2018/1/18.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "JJBannerController.h"

@interface JJBannerController()
@property (nonatomic, assign) NSInteger orgCount;
@end

@implementation JJBannerController

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.view = [[JJBannerView alloc] initWithFrame:frame];
        //self.modelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)configModelWith:(NSArray*)arr {
    
    if (IsNull(arr)) {
        return;
    }
    
    for (int i=0; i<arr.count; i++) {
        NSDictionary* dic = [arr objectAtIndex:i];
        JJBannerModel * model = [JJBannerModel modelFromDict:dic];
        if (NotNull(model)) {
            model.cellHeight = 220;
            [self.view.dataArray addObject:model];
        }
    }
    
    //----- 原始数据少于5个的时候,填充数据,最少8个,不足补齐
   _orgCount = self.view.dataArray.count;
    if (_orgCount < 5) {
        [self addMore];
    }
    
    //-----
    [self.view configCarousel];
}

- (void)addMore
{
    for (int i=0; i<_orgCount; i++) {
        [self.view.dataArray addObject:self.view.dataArray[i]];
    }
    
    if (self.view.dataArray.count < 8) {
        [self addMore];
    }
}

@end

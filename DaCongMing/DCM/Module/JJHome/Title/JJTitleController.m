//
//  JJTitleController.m
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJTitleController.h"

@implementation JJTitleController

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _view = [JJTitleView loadXIB];
        _view.frame = CGRectMake(0, 0, KSCREEN_WIDTH, TitleViewHeight);
    }
    return self;
}

- (void)fetchData {
    
//    NSDictionary* dic = @{@"englishTitle":@"englishTitle",@"title":@"title"};
//    JJTitleModel * model = [JJTitleModel modelWithDictionary:dic];
//    self.view.titleLabel.text = model.title;
//    self.view.englishTitleLabel.text = model.englishTitle;
}

@end

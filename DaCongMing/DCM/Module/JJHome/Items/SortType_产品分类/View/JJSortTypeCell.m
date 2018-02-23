//
//  JJSortTypeCell.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJSortTypeCell.h"

@implementation JJSortTypeCell

- (void)setModel:(JJProductCategoryModel *)model
{
    _imgView = [[UIImageView alloc] init];
    _imgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.contentView addSubview:_imgView];
    
    if (![model.imageUrl isEqualToString:@"zk"])
    {
        [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    }

}

@end

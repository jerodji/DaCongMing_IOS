//
//  HYRequestGoodsList.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseModel.h"

@interface HYRequestGoodsList : HYBaseModel

+ (void)requestGoodsListItem_type:(NSString *)item_type pageNo:(NSInteger )pageNo andPage:(NSInteger )pageSize complectionBlock:(void(^)(NSArray *datalist))complection;

@end

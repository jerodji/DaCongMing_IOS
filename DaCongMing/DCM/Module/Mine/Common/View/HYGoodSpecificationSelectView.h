//
//  HYGoodSpecificationSelectView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGoodsItemProp.h"


@protocol HYGoodsSpecificationSelectDelegate <NSObject>

- (void)confirmGoodsSpeciSelectWithModel:(HYGoodsItemProp *)item buyCount:(NSInteger)count;

@end


@interface HYGoodSpecificationSelectView : UIView

/** 规格数组 */
@property (nonatomic, strong) HYGoodsDetailModel *goodsModel;

/** 规格质量 */
@property (nonatomic, strong) NSMutableArray *specificationUnitArray;

/** delegate */
@property (nonatomic,weak) id<HYGoodsSpecificationSelectDelegate> delegate;

@end

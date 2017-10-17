//
//  HYAddToCartsHandle.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAddToCartsHandle.h"
#import "HYGoodsHandle.h"

@interface HYAddToCartsHandle()

/** 选择规格View */
@property (nonatomic,strong) HYGoodSpecificationSelectView *selectSpeciView;

@end

@implementation HYAddToCartsHandle


- (void)addToCartsWithProductID:(NSString *)productID{
    
    [HYGoodsHandle requestProductsDetailWithGoodsID:productID andToken:nil complectionBlock:^(HYGoodsDetailModel *model) {
        
        [KEYWINDOW addSubview:self.selectSpeciView];
        self.selectSpeciView.goodsModel = model;
        self.selectSpeciView.isAddToCarts = YES;
        [self.selectSpeciView showGoodsSpecificationView];
    }];
}

#pragma mark - 选择规格delegate
- (void)confirmGoodsSpeciSelectWithModel:(HYGoodsItemProp *)item buyCount:(NSInteger)count{
    
    if (![HYUserModel sharedInstance].token) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请登录后再加入购物车"];
        [_selectSpeciView removeFromSuperview];
        _selectSpeciView = nil;
        return;
    }
    
    if (item) {
        
        if (_selectSpeciView.isAddToCarts) {
            
            [HYGoodsHandle addToShoppingCartsItemID:item.item_id count:count andUnit:item.unit ComplectionBlock:^(BOOL isSuccess) {
                
                if (isSuccess) {
                    
                    DLog(@"添加购物车成功");
                    [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"添加购物车成功"];
                }
                
                [_selectSpeciView removeFromSuperview];
                _selectSpeciView = nil;
            }];
        }
        
    }
    else{
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请选择商品规格"];
    }
}

- (HYGoodSpecificationSelectView *)selectSpeciView{
    
    if (!_selectSpeciView) {
        
        _selectSpeciView = [[HYGoodSpecificationSelectView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _selectSpeciView.delegate = self;
    }
    return _selectSpeciView;
}



@end

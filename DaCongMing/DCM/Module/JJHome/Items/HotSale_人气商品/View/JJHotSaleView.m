//
//  JJHotSaleView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJHotSaleView.h"
#import "iCarousel.h"
#import "HYGoodSpecificationSelectView.h"
#import "HYGoodsHandle.h"
#import "HYFillOrderViewController.h"

@interface JJHotSaleView()<iCarouselDelegate, iCarouselDataSource,HYGoodsSpecificationSelectDelegate>
@property (nonatomic, strong) iCarousel * carousel;
/** 选择规格View */
@property (nonatomic,strong) HYGoodSpecificationSelectView *selectSpeciView;
@property (nonatomic,strong) HYGoodsDetailModel* detailModel;
@end

@implementation JJHotSaleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        _modelArray = [[NSMutableArray alloc] init];
        
        self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, HeightHotSale+10)];
        self.carousel.backgroundColor = [UIColor clearColor];
        self.carousel.delegate = self;
        self.carousel.dataSource = self;
        self.carousel.decelerationRate = 0.8;
        self.carousel.type = iCarouselTypeRotary;
        [self addSubview:self.carousel];
    }
    return self;
}

- (void)updateUI {
    [self.carousel reloadData];
}

- (HYGoodSpecificationSelectView *)selectSpeciView{
    
    if (!_selectSpeciView) {
        
        _selectSpeciView = [[HYGoodSpecificationSelectView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _selectSpeciView.delegate = self;
        _selectSpeciView.showCB = ^{
            
        };
        _selectSpeciView.hiddenCB = ^{
            
        };
    }
    return _selectSpeciView;
}

#pragma mark - HYGoodSpecificationSelectView delegate
- (void)confirmGoodsSpeciSelectWithModel:(HYGoodsItemProp *)item buyCount:(NSInteger)count {
    if([HYUserHandle jumpToLoginViewControllerFromVC:self.viewController])
        return ;
    
    if (item) {
        
        if (_selectSpeciView.isAddToCarts) {
            
            [HYGoodsHandle addToShoppingCartsItemID:item.item_id count:count andUnit:item.unit ComplectionBlock:^(BOOL isSuccess,NSString *cartsCount) {
                
                if (isSuccess) {
                    
                    NSLog(@"添加购物车成功");
                    [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"添加购物车成功"];
                    
                    //发出通知，刷新购物车列表
                    [[NSNotificationCenter defaultCenter] postNotificationName:KAddShoppingCartsSuccess object:cartsCount];
                }
                
                [_selectSpeciView removeFromSuperview];
                _selectSpeciView = nil;
            }];
        }
        else{
            
            HYFillOrderViewController *fillOrderVC = [[HYFillOrderViewController alloc] init];
            fillOrderVC.goodsDetailModel = _detailModel;
            fillOrderVC.specifical = item.unit;
            fillOrderVC.buyCount = count;
            [self.navigationController pushViewController:fillOrderVC animated:YES];
        }
        
    }
    else{
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请选择商品规格"];
    }
    
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.modelArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    JJCarouselCell* cellView = [JJCarouselCell loadXIB];
    cellView.frame = CGRectMake(0, 0, 166, 243);
    
    if (index < self.modelArray.count) {
        [cellView setModel:_modelArray[index]];
    }
    
    __weak typeof(self) weakSelf = self;
    cellView.addCartCB = ^{
        JJCarouselCellModel* model = [_modelArray objectAtIndex:index];
        NSLog(@"准备加入购物车! %@",model.itemName);
        //API_GoodsDetail
        [HYGoodsHandle requestProductsDetailWithGoodsID:model.itemId andToken:nil complectionBlock:^(HYGoodsDetailModel *Detailmodel, HYCommentModel *commentModel) {
            weakSelf.detailModel = Detailmodel;
            weakSelf.selectSpeciView.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
            //[weakSelf.viewController.view addSubview:weakSelf.selectSpeciView];
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.selectSpeciView];
            weakSelf.selectSpeciView.goodsModel = Detailmodel;
            weakSelf.selectSpeciView.isAddToCarts = YES;
            //规格
            [weakSelf.selectSpeciView showGoodsSpecificationView];
        }];
    };
    
    return cellView;
}

#pragma mark iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    if (self.modelArray.count <= 5) {
        return 500;
    }
    return 280;
}

//- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
//
//}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了,jumpURL == %@",[self.modelArray objectAtIndex:index].jumpUrl);
    [DCURLRouter pushURLString:[self.modelArray objectAtIndex:index].jumpUrl animated:YES];
}

@end

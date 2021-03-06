//
//  HYGoodSpecificationSelectView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYGoodsItemProp.h"


@protocol HYGoodsSpecificationSelectDelegate <NSObject>

- (void)confirmGoodsSpeciSelectWithModel:(HYGoodsItemProp *)item buyCount:(NSInteger)count;

@end

typedef void (^SHOWBLK)();
typedef void (^HIDDENBLK)();

@interface HYGoodSpecificationSelectView : UIView

@property (nonatomic, copy) SHOWBLK showCB;
@property (nonatomic, copy) HIDDENBLK hiddenCB;

/** 规格数组 */
@property (nonatomic, strong) HYGoodsDetailModel *goodsModel;

/** 规格质量 */
@property (nonatomic, strong) NSMutableArray *specificationUnitArray;

/** delegate */
@property (nonatomic,strong) id<HYGoodsSpecificationSelectDelegate> delegate;

/** 购物车还是下单 */
@property (nonatomic,assign) BOOL isAddToCarts;

- (void)showGoodsSpecificationView;

@end

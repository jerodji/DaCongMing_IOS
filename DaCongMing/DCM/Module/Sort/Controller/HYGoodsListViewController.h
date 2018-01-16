//
//  HYGoodsListViewController.h
//  DaCongMing
//
//

#import "HYBaseViewController.h"

typedef NS_ENUM(NSUInteger, HYGoodsListType) {
    HYGoodsListTypeDefault = 0,
    HYGoodsListTypeSalesVolumeDesc,
    HYGoodsListTypeSalesVolumeAesc,
    HYGoodsListTypePriceDesc,
    HYGoodsListTypePriceAesc
};

@interface HYGoodsListViewController : HYBaseViewController

/** type */
@property (nonatomic,copy) NSString *type;
/** 关键字 */
@property (nonatomic,strong) NSString *keyword;

@end

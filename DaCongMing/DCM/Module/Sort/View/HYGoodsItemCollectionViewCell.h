//
//  HYGoodsItemCollectionViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

#define itemWidth (KSCREEN_WIDTH - 30) / 2

@interface HYGoodsItemCollectionViewCell : UICollectionViewCell

/** model */
@property (nonatomic,strong) HYGoodsItemModel *goodsModel;

@end

//
//  HYGoodsCollectionView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@interface HYGoodsCollectionView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;

@end

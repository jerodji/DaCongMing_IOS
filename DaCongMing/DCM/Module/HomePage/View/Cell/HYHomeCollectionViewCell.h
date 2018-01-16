//
//  HYHomeCollectionViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYReCommendTday.h"
#import "HYItemListModel.h"

@interface HYHomeCollectionViewCell : UICollectionViewCell

/** model */
@property (nonatomic,strong) HYReCommendTday *commendTodayModel;

/** 健康养生 itemList */
@property (nonatomic,strong) HYItemListModel *itemListModel;

@end

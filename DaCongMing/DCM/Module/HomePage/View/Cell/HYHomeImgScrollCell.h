//
//  HYHomeImgScrollCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYGoodHealthModel.h"

typedef void(^collectionSelectBlock)(NSString *productID);

@interface HYHomeImgScrollCell : UITableViewCell

/** model */
@property (nonatomic,strong) HYGoodHealthModel *goodHealthModel;

/** 点击collectionBlock */
@property (nonatomic,copy) collectionSelectBlock collectionSelect;

/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;

@end

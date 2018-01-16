//
//  HYHomeDoodsCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^collectionSelectBlock)(NSString *productID);

@interface HYHomeDoodsCell : UITableViewCell

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;

/** 点击collectionBlock */
@property (nonatomic,copy) collectionSelectBlock collectionSelect;

/** title */
@property (nonatomic,strong) NSString *title;

@end

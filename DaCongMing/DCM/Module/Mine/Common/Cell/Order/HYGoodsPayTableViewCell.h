//
//  HYGoodsPayTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^orderPayMode)(NSInteger mode);

@interface HYGoodsPayTableViewCell : UITableViewCell

/** orderMode */
@property (nonatomic,strong) HYCreateOrder *orderModel;

/** 支付方式回调 */
@property (nonatomic,copy) orderPayMode orderPayModeBlock;

@end

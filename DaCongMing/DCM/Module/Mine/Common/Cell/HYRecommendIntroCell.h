//
//  HYRecommendIntroCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYLabel.h"
#import "HYSystemMessageModel.h"

@interface HYRecommendIntroCell : UITableViewCell

@property (nonatomic,strong) HYSystemMessageModel * SystemMessageModel;

/** 支付金额 */
@property (nonatomic,copy) NSString *payAmount;

/* level */
@property (nonatomic,copy) NSString * unit;

@property (nonatomic,copy) NSString * time;

/** 邀请人 */
@property (nonatomic,strong) UILabel *inviterLabel;

/** 推荐 */
@property (nonatomic,strong) UILabel *recommendLabel;
/** 剩余支付时间 */
@property (nonatomic,strong) UILabel *payTimeLabel;

/** 介绍 */
@property (nonatomic,strong) UILabel *introLabel; /* 说明 */
/** 介绍文本 */
@property (nonatomic,strong) HYLabel *introTextLabel; /* 说明的内容 */
@property (nonatomic,strong) UIView * line;
/** 加盟费 */
@property (nonatomic,strong) UILabel *payMoneyLabel;

@property (nonatomic,strong) UIImageView * levelImageView;

@end

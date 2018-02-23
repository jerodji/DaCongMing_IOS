//
//  HYMineHeaderView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYMyUserInfo.h"

typedef void(^HeadIconBLK)();

@protocol HYMineHeaderTapDelegate <NSObject>

- (void)headerBtnTapIndex:(NSInteger)index;

@end

@interface HYMineHeaderView : UIView

@property (nonatomic,copy) HeadIconBLK headerIconClickCB;

/** user */
@property (nonatomic,strong) HYUserModel *user;
/** 收藏信息 */
@property (nonatomic,strong) HYMyUserInfo *myUserInfo;
/** delegate */
@property (nonatomic,weak) id<HYMineHeaderTapDelegate>delegate;


/** 背景 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** header */
@property (nonatomic,strong) UIImageView *headerImgView;
/** 用户昵称 */
@property (nonatomic,strong) UILabel *nickNameLabel;
/** 翅膀 */
@property (nonatomic,strong) UIImageView *wingImgView;
/** 收藏商品 */
@property (nonatomic,strong) UILabel *collectGoodsLabel;
/** 收藏店铺 */
@property (nonatomic,strong) UILabel *collectStoreLabel;
/** 最近浏览 */
@property (nonatomic,strong) UILabel *recentViewLabel;

@end

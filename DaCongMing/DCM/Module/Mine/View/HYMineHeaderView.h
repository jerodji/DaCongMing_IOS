//
//  HYMineHeaderView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYMyUserInfo.h"

@protocol HYMineHeaderTapDelegate <NSObject>

- (void)headerBtnTapIndex:(NSInteger)index;

@end

@interface HYMineHeaderView : UIView

/** user */
@property (nonatomic,strong) HYUserModel *user;
/** 收藏信息 */
@property (nonatomic,strong) HYMyUserInfo *myUserInfo;
/** delegate */
@property (nonatomic,weak) id<HYMineHeaderTapDelegate>delegate;

@end

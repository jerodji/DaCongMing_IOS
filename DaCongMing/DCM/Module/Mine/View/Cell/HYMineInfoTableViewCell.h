//
//  HYMineInfoTableViewCell.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@protocol HYMineInfoBtnActionDelegate <NSObject>

- (void)jumpToMineInfoDetailVCWithTag:(NSInteger)tag;

@end


@interface HYMineInfoTableViewCell : UITableViewCell

/** delegate */
@property (nonatomic,weak) id<HYMineInfoBtnActionDelegate>delegate;

@end

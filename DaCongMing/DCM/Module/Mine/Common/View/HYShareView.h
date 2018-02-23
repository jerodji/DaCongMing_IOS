//
//  HYShareView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>
#import "HYShareModel.h"


@interface HYShareView : UIView

@property (nonatomic,strong) HYShareModel *shareModel;

- (void)showShareView;

- (void)hideShareView;

@end

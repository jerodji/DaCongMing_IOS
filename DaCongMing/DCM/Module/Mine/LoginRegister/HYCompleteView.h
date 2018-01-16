//
//  HYCompleteView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^SkipBlock)();
typedef void(^ConfirmBlock)(NSString *phone);

@interface HYCompleteView : UIView

/** skipBtn */
@property (nonatomic,strong) UIButton *skipBtn;

/** skipBlock */
@property (nonatomic,copy) SkipBlock skipBlock;
/** confirmBlock */
@property (nonatomic,copy) ConfirmBlock confirmBlock;


@end

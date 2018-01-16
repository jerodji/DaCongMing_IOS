//
//  HYHotSearchView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@protocol HYHotSearchBtnActionDelegate <NSObject>

- (void)hotSearchBtnTapWithText:(NSString *)text;

@end

@interface HYHotSearchView : UIView

/** delegate */
@property (nonatomic,weak) id<HYHotSearchBtnActionDelegate> delegate;

@end

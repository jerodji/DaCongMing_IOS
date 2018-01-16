//
//  HYMyOrderTitleView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@protocol MyOrderTitleChangedDelegate <NSObject>

- (void)titleChanged:(NSInteger)index;

@end

@interface HYMyOrderTitleView : UIView

/** 记录上一次点击的index */
@property (nonatomic,assign) NSInteger previousSelectIndex;

/** line */
@property (nonatomic,strong) UIView *line;

/** delegate */
@property (nonatomic,weak) id<MyOrderTitleChangedDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame WithTitleArray:(NSArray *)titleArray;

@end

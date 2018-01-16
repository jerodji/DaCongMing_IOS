//
//  HYNoDiscountCouponView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^strollActionBlock)();

@interface HYNoDiscountCouponView : UIView

/** strollActin */
@property (nonatomic,copy) strollActionBlock strollActin;

@end

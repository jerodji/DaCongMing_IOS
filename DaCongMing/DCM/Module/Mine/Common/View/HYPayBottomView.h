//
//  HYPayBottomView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

typedef void(^PayBlock)();

@interface HYPayBottomView : UIView

/** 支付金额 */
@property (nonatomic,strong) NSString *payAmount;
/** 支付按钮 */
@property (nonatomic,copy) PayBlock payBlock;
/** 支付 */
@property (nonatomic,strong) UIButton *payBtn;


//网银线下支付参数
@property (nonatomic,copy) NSString * bank;
@property (nonatomic,copy) NSString * acount;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * phone;

@end

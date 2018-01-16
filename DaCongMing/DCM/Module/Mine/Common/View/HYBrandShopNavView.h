//
//  HYBrandShopNavView.h
//  DaCongMing
//
//

#import <UIKit/UIKit.h>

@protocol HYBrandsShopTapDelegate <NSObject>

- (void)brandsShopNavBtnTapIndex:(NSInteger)index;

- (void)searchTextFieldTextChanged:(NSString *)text;

- (void)searchTextFieldStartInput;

- (void)searchTextFieldResignFirstResponder;

@end

@interface HYBrandShopNavView : UIView

/** delegate */
@property (nonatomic,weak) id<HYBrandsShopTapDelegate> delegate;
/** textField */
@property (nonatomic,strong) UITextField *textField;

@end

//
//  HYSearchTitleView.h
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelActionBlock)();

@protocol HYSearchTextFieldTextChangedDelegate <NSObject>

- (void)searchTextFieldTextChanged:(NSString *)text;

- (void)searchTextFieldStartInput;

- (void)searchTextFieldResignFirstResponder;

@end

@interface HYSearchTitleView : UIView

/** textField */
@property (nonatomic,strong) UITextField *textField;

/**  */
@property (nonatomic,strong) cancelActionBlock cancenBlock;

/** delegate */
@property (nonatomic,weak) id<HYSearchTextFieldTextChangedDelegate> delegate;

@end

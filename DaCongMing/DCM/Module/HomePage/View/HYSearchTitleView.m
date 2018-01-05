//
//  HYSearchTitleView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSearchTitleView.h"

@interface HYSearchTitleView() <UITextFieldDelegate>

/** 搜索View */
@property (nonatomic,strong) UIView *searchView;
/** searchIcon */
@property (nonatomic,strong) UIImageView *searchIconImgView;
/** 取消 */
@property (nonatomic,strong) UIButton *cancelBtn;

@end

@implementation HYSearchTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.searchView];
    [self addSubview:self.searchIconImgView];
    [self addSubview:self.textField];
    [self addSubview:self.cancelBtn];

}

- (void)layoutSubviews{
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(6);
        make.bottom.equalTo(self).offset(-6);
        make.right.equalTo(self);
        make.width.equalTo(@60);
    }];
    
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.bottom.equalTo(_cancelBtn);
        make.right.equalTo(_cancelBtn.mas_left);
    }];
    
    [self.searchIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.searchView).offset(7 * WIDTH_MULTIPLE);
        make.top.equalTo(self.searchView).offset(6);
        make.bottom.equalTo(self.searchView).offset(-6);
        make.width.equalTo(@30);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_searchIconImgView.mas_right).offset(5);
        make.top.bottom.equalTo(_searchView);
        make.right.equalTo(_searchView.mas_right).offset(-5);
    }];
}

#pragma mark - action
- (void)cancelBtnAction{
    
    self.cancenBlock();
}

- (void)searchTextChanged:(UITextField *)textField{
    
    DLog(@"%@",textField.text);
    if (_delegate && [_delegate respondsToSelector:@selector(searchTextFieldTextChanged:)]) {
        
        [_delegate searchTextFieldTextChanged:textField.text];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField.text isNotBlank]) {
        
        return YES;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_delegate && [_delegate respondsToSelector:@selector(searchTextFieldResignFirstResponder)]) {
        
        [_delegate searchTextFieldResignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_delegate && [_delegate respondsToSelector:@selector(searchTextFieldStartInput)]) {
        
        [_delegate searchTextFieldStartInput];
    }
}

#pragma mark - lazyload
- (UIView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[UIView alloc] initWithFrame:CGRectZero];
        _searchView.layer.cornerRadius = 6;
        _searchView.backgroundColor = KAPP_WHITE_COLOR;
        _searchView.userInteractionEnabled = YES;
    }
    return _searchView;
}

- (UIImageView *)searchIconImgView{
    
    if (!_searchIconImgView) {
        
        _searchIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _searchIconImgView.image = [UIImage imageNamed:@"home_searchIcon"];
        _searchIconImgView.contentMode = UIViewContentModeScaleAspectFit;
        _searchIconImgView.clipsToBounds = YES;
    }
    
    return _searchIconImgView;
}

- (UITextField *)textField{
    
    if (!_textField) {
        
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索你想要的产品" attributes:@{NSForegroundColorAttributeName: KAPP_b7b7b7_COLOR ,NSFontAttributeName : KFitFont(14)}];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.font = KFitFont(14);
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.tintColor = KAPP_b7b7b7_COLOR;
        [_textField addTarget:self action:@selector(searchTextChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = KFitFont(14);
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


@end

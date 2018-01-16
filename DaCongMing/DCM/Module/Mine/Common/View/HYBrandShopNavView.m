//
//  HYBrandShopNavView.m
//  DaCongMing
//
//

#import "HYBrandShopNavView.h"

@interface HYBrandShopNavView() <UITextFieldDelegate>

/** back */
@property (nonatomic,strong) UIButton *backBtn;
/** 搜索View */
@property (nonatomic,strong) UIView *searchView;
/** searchIcon */
@property (nonatomic,strong) UIImageView *searchIconImgView;
/** filt */
@property (nonatomic,strong) UIButton *filtBtn;
/** shareBtn */
@property (nonatomic,strong) UIButton *shareBtn;

@end

@implementation HYBrandShopNavView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_NAV_COLOR;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.backBtn];
    [self addSubview:self.searchView];
    [self addSubview:self.searchIconImgView];
    [self addSubview:self.textField];
    //[self addSubview:self.filtBtn];
    [self addSubview:self.shareBtn];
}

- (void)layoutSubviews{
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self).offset(6);
        make.bottom.equalTo(self).offset(-6);
        make.left.equalTo(self);
        make.width.equalTo(@30);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(6);
        make.bottom.equalTo(self).offset(-6);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@30);
    }];
    
//    [_filtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self).offset(6);
//        make.bottom.equalTo(self).offset(-6);
//        make.right.equalTo(_shareBtn.mas_left).offset(-10);
//        make.width.equalTo(@30);
//    }];
    
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_backBtn.mas_right).offset(8);
        make.top.bottom.equalTo(_backBtn);
        make.right.equalTo(_shareBtn.mas_left).offset(-10);
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
- (void)buttonAction:(UIButton *)button{
    
    if (_delegate && [_delegate respondsToSelector:@selector(brandsShopNavBtnTapIndex:)]) {
        
        [_delegate brandsShopNavBtnTapIndex:button.tag - 300];
    }
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
- (UIButton *)backBtn{
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backBtn.tag = 300;
        [_backBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

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
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索店铺内的商品" attributes:@{NSForegroundColorAttributeName: KAPP_b7b7b7_COLOR ,NSFontAttributeName : KFitFont(14)}];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.font = KFitFont(14);
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textField.tintColor = KAPP_7b7b7b_COLOR;
         [_textField addTarget:self action:@selector(searchTextChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIButton *)filtBtn{
    
    if (!_filtBtn) {
        
        _filtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_filtBtn setImage:[UIImage imageNamed:@"filt"] forState:UIControlStateNormal];
        _filtBtn.tag = 301;
        [_filtBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filtBtn;
}

- (UIButton *)shareBtn{
    
    if (!_shareBtn) {
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        _shareBtn.tag = 302;
        [_shareBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

@end

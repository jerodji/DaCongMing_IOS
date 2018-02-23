//
//  HYNoDiscountCouponView.m
//  DaCongMing
//
//

#import "HYNoDiscountCouponView.h"

@interface HYNoDiscountCouponView()

/** imgView */
@property (nonatomic,strong) UIImageView *imgView;
/** text */
@property (nonatomic,strong) UILabel *textLabel;
/** 逛逛 */
@property (nonatomic,strong) UIButton *strollBtn;

@end

@implementation HYNoDiscountCouponView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.imgView];
    [self addSubview:self.textLabel];
    [self addSubview:self.strollBtn];

}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(150 * WIDTH_MULTIPLE);
        make.width.left.equalTo(self);
        make.height.equalTo(@(60 * WIDTH_MULTIPLE));
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_imgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.height.equalTo(@(30));
    }];
    
    [_strollBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_textLabel.mas_bottom).offset(20);
        make.width.equalTo(@(100 * WIDTH_MULTIPLE));
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
        make.centerX.equalTo(self);
    }];
}

#pragma mark - action
- (void)strollBtnAction{
    if (self.strollActin) {
        self.strollActin();
    }
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.image = [UIImage imageNamed:@"discountConpon"];
    }
    
    return _imgView;
}

- (UILabel *)textLabel{
    
    if (!_textLabel) {
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = KFitFont(14);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = KAPP_7b7b7b_COLOR;
        _textLabel.text = @"你还没有任何优惠券";
    }
    return _textLabel;
}

- (UIButton *)strollBtn{
    
    if (!_strollBtn) {
        
        _strollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_strollBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [_strollBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _strollBtn.titleLabel.font = KFitFont(14);
        _strollBtn.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _strollBtn.layer.borderColor = KCOLOR(@"383938").CGColor;
        _strollBtn.layer.borderWidth = 1;
        [_strollBtn addTarget:self action:@selector(strollBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _strollBtn;
}

@end

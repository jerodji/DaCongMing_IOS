
//
//  HYNoAddressView.m
//  DaCongMing
//
//

#import "HYNoAddressView.h"

@interface HYNoAddressView()

/** imgView */
@property (nonatomic,strong) UIImageView *imgView;
/** text */
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation HYNoAddressView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KCOLOR(@"f4f4f4");
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.imgView];
    [self addSubview:self.textLabel];
    
}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(90 * WIDTH_MULTIPLE);
        make.width.left.equalTo(self);
        make.height.equalTo(@(150 * WIDTH_MULTIPLE));
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.top.equalTo(_imgView.mas_bottom).offset(20 * WIDTH_MULTIPLE);
        make.height.equalTo(@(30));
    }];
    
    
}


#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.image = [UIImage imageNamed:@"address"];
    }
    
    return _imgView;
}

- (UILabel *)textLabel{
    
    if (!_textLabel) {
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = KFitFont(15);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = KAPP_7b7b7b_COLOR;
        _textLabel.text = @"你还没有添加地址";
    }
    return _textLabel;
}

@end

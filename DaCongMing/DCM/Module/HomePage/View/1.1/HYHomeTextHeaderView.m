//
//  HYHomeTextHeaderView.m
//  DaCongMing
//
//

#import "HYHomeTextHeaderView.h"

@interface HYHomeTextHeaderView ()

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *titleChineseLabel;
@property (nonatomic,strong) UILabel *titleEngnishLabel;

@end

@implementation HYHomeTextHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.lineView];
    [self addSubview:self.titleChineseLabel];
    [self addSubview:self.titleEngnishLabel];
}

- (void)layoutSubviews{
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(3 * WIDTH_MULTIPLE);
    }];
    
    [_titleChineseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_lineView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_lineView);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
    }];
    
    [_titleEngnishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.right.equalTo(self);
        make.left.equalTo(_titleChineseLabel);
        make.height.mas_equalTo(15 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [UIView new];
        _lineView.backgroundColor = KAPP_BLACK_COLOR;
    }
    return _lineView;
}

- (UILabel *)titleChineseLabel{
    
    if (!_titleChineseLabel) {
        
        _titleChineseLabel = [UILabel new];
        _titleChineseLabel.font = KFitBoldFont(14);
        _titleChineseLabel.textAlignment = NSTextAlignmentLeft;
        _titleChineseLabel.textColor = KAPP_BLACK_COLOR;
        _titleChineseLabel.text = @"产品分类";
    }
    return _titleChineseLabel;
}

- (UILabel *)titleEngnishLabel{
    
    if (!_titleEngnishLabel) {
        
        _titleEngnishLabel = [UILabel new];
        _titleEngnishLabel.font = KFitBoldFont(9);
        _titleEngnishLabel.textAlignment = NSTextAlignmentLeft;
        _titleEngnishLabel.textColor = KAPP_BLACK_COLOR;
        _titleEngnishLabel.text = @"Product category";
    }
    return _titleEngnishLabel;
}

@end

//
//  HYMyOrderTitleView.m
//  DaCongMing
//
//

#import "HYMyOrderTitleView.h"

@interface HYMyOrderTitleView()


/** 存放btn */
@property (nonatomic,strong) NSMutableArray *btnArray;
/** array */
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation HYMyOrderTitleView

- (instancetype)initWithFrame:(CGRect)frame WithTitleArray:(NSArray *)titleArray{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KAPP_WHITE_COLOR;
        [self createButtonWithArray:titleArray];
        self.titleArray = titleArray;
        [self addSubview:self.line];
    }
    return self;
}

- (void)createButtonWithArray:(NSArray *)array{
    
    CGFloat width = KSCREEN_WIDTH / array.count;
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        [button setTitleColor:KAPP_THEME_COLOR  forState:UIControlStateSelected];
        button.frame = CGRectMake(i * width, 0, width, self.height);
        button.tag = 100 + i;
        button.backgroundColor = KAPP_WHITE_COLOR;
        [button addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self.btnArray addObject:button];
    }
}

- (void)layoutSubviews{
    
    CGFloat width = KSCREEN_WIDTH / self.titleArray.count;
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self).offset(2);
//        make.width.equalTo(@(width - 4));
//        make.height.equalTo(@2);
//        make.bottom.equalTo(self);
//    }];
}

- (void)setPreviousSelectIndex:(NSInteger)previousSelectIndex{
    
    _previousSelectIndex = previousSelectIndex;
    for (UIButton *btn in self.btnArray) {
        
        UIButton *selectBtn = [self viewWithTag:self.previousSelectIndex + 100];
        if (selectBtn == btn) {
            
            [self titleButtonAction:btn];
        }
        else{
            btn.selected = NO;
        }
    }
    
}

#pragma mark - action
- (void)titleButtonAction:(UIButton *)button{
    
    for (UIButton *btn in self.btnArray) {
        
        if (btn == button) {
            
            button.selected = YES;
        }
        else{
            btn.selected = NO;
        }
    }
    _previousSelectIndex = button.tag - 100;
    
    CGFloat width = KSCREEN_WIDTH / self.titleArray.count;
    [UIView animateWithDuration:0.2 animations:^{
       
        [_line mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(_previousSelectIndex * width + 2);
            make.width.equalTo(@(width - 4));
            make.height.equalTo(@2);
            make.bottom.equalTo(self);
        }];
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(titleChanged:)]) {
        
        [_delegate titleChanged:_previousSelectIndex];
    }
}

#pragma mark - lazyload
- (UIView *)line{
    
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = KAPP_THEME_COLOR;
    }
    return _line;
}

- (NSMutableArray *)btnArray{
    
    if (!_btnArray) {
         _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

@end

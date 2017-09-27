//
//  HYHotSearchView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHotSearchView.h"

@interface HYHotSearchView()

/** title */
@property (nonatomic,strong) UILabel *hotSearchLabel;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;
/** titleArray */
@property (nonatomic,copy) NSArray *titleArray;
/** randomArray */
@property (nonatomic,strong) NSMutableArray *randomArray;

@end

@implementation HYHotSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleArray = @[@"灵芝",@"石斛",@"燕窝",@"正宗普洱",@"野生玫瑰",@"西湖龙井",@"鹿茸",@"三七花",@"罗汉果",@"果仁"];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.hotSearchLabel];
    [self addSubview:self.bottomLine];
    
    [self.randomArray addObjectsFromArray:self.titleArray];
    UIButton *lastButton = nil;
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 4;
        button.layer.borderColor = KAPP_7b7b7b_COLOR.CGColor;
        button.layer.borderWidth = 1;
        button.layer.masksToBounds = YES;
        button.backgroundColor = KAPP_WHITE_COLOR;
        [button setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        button.titleLabel.font = KFitFont(12);
        button.highlighted = NO;
        button.tag = 1000 + i;
    
        NSString *title = [_randomArray randomObject];
        [_randomArray removeObject:title];
        
        CGFloat itemWidth = [title widthForFont:KFitFont(12)] + 20;
        [button setTitle:title forState:UIControlStateNormal];
        [self addSubview:button];
        
        if (lastButton) {
            
            if (lastButton.right + 30 + itemWidth > KSCREEN_WIDTH) {
                
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(lastButton.mas_bottom).offset(12 * WIDTH_MULTIPLE);
                    make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
                    make.width.equalTo(@(itemWidth));
                    make.height.equalTo(@(20));
                }];
            }
            else{
                
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.top.equalTo(lastButton);
                    make.left.equalTo(lastButton.mas_right).offset(12 * WIDTH_MULTIPLE);
                    make.width.equalTo(@(itemWidth));
                    make.height.equalTo(@(20));
                }];
            }
            
            
        }
        else{
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(_hotSearchLabel.mas_bottom).offset(20);
                make.left.equalTo(self).mas_offset(20 * WIDTH_MULTIPLE);
                make.width.equalTo(@(itemWidth));
                make.height.equalTo(@(20));
            }];
        }
        
        lastButton = button;
        [self layoutIfNeeded];
    }
}

- (void)layoutSubviews{
    
    [_hotSearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.size.mas_offset(CGSizeMake(150, 20));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

#pragma mark - lazyload
- (UILabel *)hotSearchLabel{
    
    if (!_hotSearchLabel) {
        
        _hotSearchLabel = [[UILabel alloc] init];
        _hotSearchLabel.font = KFitFont(15);
        _hotSearchLabel.textColor = KCOLOR(@"272727");
        _hotSearchLabel.text = @"热搜";
        _hotSearchLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _hotSearchLabel;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (NSMutableArray *)randomArray{
    
    if (!_randomArray) {
        
        _randomArray = [NSMutableArray array];
    }
    return _randomArray;
}

@end

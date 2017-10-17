//
//  HYSearchNoDataCollectionReusableView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSearchNoDataCollectionReusableView.h"

@interface HYSearchNoDataCollectionReusableView()

/** white */
@property (nonatomic,strong) UIView *whiteBgView;
/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;
/** noData */
@property (nonatomic,strong) UILabel *noDataLabel;
/** 大家都在找 */
@property (nonatomic,strong) UILabel *allFindLabel;

@end

@implementation HYSearchNoDataCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.iconImgView];
    [self addSubview:self.noDataLabel];
    [self addSubview:self.allFindLabel];
}

- (void)layoutSubviews{
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).offset(-45 * WIDTH_MULTIPLE);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(25 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(60 * 163 / 125 * WIDTH_MULTIPLE, 60 * WIDTH_MULTIPLE));
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.right.equalTo(_whiteBgView);
        make.left.equalTo(_iconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_allFindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(45 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _whiteBgView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"searchNoData"];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UILabel *)noDataLabel{
    
    if (!_noDataLabel) {
        
        _noDataLabel = [UILabel new];
        _noDataLabel.text = @"没有为您找到相关产品";
        _noDataLabel.font = KFitFont(16);
        _noDataLabel.textColor = KAPP_272727_COLOR;
        _noDataLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _noDataLabel;
}

- (UILabel *)allFindLabel{
    
    if (!_allFindLabel) {
        
        _allFindLabel = [UILabel new];
        _allFindLabel.text = @"大家都在找";
        _allFindLabel.font = KFitFont(18);
        _allFindLabel.textColor = KAPP_b7b7b7_COLOR;
        _allFindLabel.textAlignment = NSTextAlignmentCenter;
        _allFindLabel.backgroundColor = KCOLOR(@"f6f6f6");
    }
    return _allFindLabel;
}

@end

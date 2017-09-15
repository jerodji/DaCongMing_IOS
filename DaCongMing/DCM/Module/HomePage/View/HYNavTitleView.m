//
//  HYNavTitleView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYNavTitleView.h"

@interface HYNavTitleView()

/** img */
@property (nonatomic,strong) UIImageView *iconImgView;
/** 搜索View */
@property (nonatomic,strong) UIView *searchView;

/** searchIcon */
@property (nonatomic,strong) UIImageView *searchIconImgView;
/** searchLabel */
@property (nonatomic,strong) UILabel *searchLabel;

@end

@implementation HYNavTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconImgView];
        [self addSubview:self.searchView];
        [self.searchView addSubview:self.searchIconImgView];
        [self.searchView addSubview:self.searchLabel];
        
        [self masLayout];
    }
    return self;
}

- (void)masLayout{

    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(14 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@83);
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.iconImgView.mas_right).offset(14 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(4 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(- 4 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(- 23);
       
    }];
    
    [self.searchIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.searchView).offset(7 * WIDTH_MULTIPLE);
        make.top.equalTo(self.searchView).offset(5);
        make.bottom.equalTo(self.searchView).offset(-5);
        make.width.equalTo(@20);
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.searchIconImgView.mas_right).offset(13);
        make.top.bottom.right.equalTo(self.searchView);
    }];
}

#pragma mark - lazyload
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        _iconImgView.image = [UIImage imageNamed:@"home_title_icon"];
    }
    
    return _iconImgView;
}

- (UIView *)searchView{
    
    if (!_searchView) {
        
        _searchView = [[UIView alloc] initWithFrame:CGRectZero];
        _searchView.layer.cornerRadius = 6;
        _searchView.backgroundColor = KAPP_WHITE_COLOR;
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            
            NSLog(@"tap the search view");
        }];
        [_searchView addGestureRecognizer:tap];
        _searchView.userInteractionEnabled = YES;
    }
    return _searchView;
}

- (UIImageView *)searchIconImgView{
    
    if (!_searchIconImgView) {
        
        _searchIconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _searchIconImgView.image = [UIImage imageNamed:@"home_searchIcon"];
        _searchIconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _searchIconImgView.clipsToBounds = YES;
    }
    
    return _searchIconImgView;
}

- (UILabel *)searchLabel{
    
    if (!_searchLabel) {
        
        _searchLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _searchLabel.text = @"愿你出走半生，归来仍是少年";
        _searchLabel.textAlignment = NSTextAlignmentLeft;
        _searchLabel.textColor = KCOLOR(@"b7b7b7");
        _searchLabel.font = KFont(12);
    }
    return _searchLabel;
}

@end

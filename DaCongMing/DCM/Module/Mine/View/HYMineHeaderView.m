//
//  HYMineHeaderView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMineHeaderView.h"

@interface HYMineHeaderView()

/** 背景 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** header */
@property (nonatomic,strong) UIImageView *headerImgView;
/** 用户昵称 */
@property (nonatomic,strong) UILabel *nickNameLabel;
/** 收藏商品 */
@property (nonatomic,strong) UILabel *collectGoodsLabel;
/** 收藏店铺 */
@property (nonatomic,strong) UILabel *collectStoreLabel;
/** 最近浏览 */
@property (nonatomic,strong) UILabel *recentViewLabel;

@end

@implementation HYMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews{
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.headerImgView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.collectGoodsLabel];
    [self addSubview:self.collectStoreLabel];
    [self addSubview:self.recentViewLabel];
}

#pragma mark - setter
- (void)setUser:(HYUserModel *)user{
    
    _user = user;
    
    if ([user.token isNotBlank]) {
        
        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:user.userInfo.head_image_url] placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
//        NSString *urlStr = [NSString stringWithFormat:@"http://%@",user.userInfo.head_image_url];
//        [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
        self.nickNameLabel.text = user.userInfo.name;
    }
}

- (void)setMyUserInfo:(HYMyUserInfo *)myUserInfo{
    
    _myUserInfo = myUserInfo;
    _collectGoodsLabel.text = [NSString stringWithFormat:@"%@\n收藏的商品",myUserInfo.favItemNum];
    _collectStoreLabel.text = [NSString stringWithFormat:@"%@\n收藏的店铺",myUserInfo.favStoreNum];
}

- (void)layoutSubviews{
    
    CGFloat itemWidth = self.width / 3;
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self);
    }];
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(42 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@(60 * WIDTH_MULTIPLE));
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_headerImgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    [_collectGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.equalTo(@(itemWidth));
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(10 *WIDTH_MULTIPLE);
    }];
    
    [_collectStoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectGoodsLabel.mas_right);
        make.bottom.equalTo(self.collectGoodsLabel);
        make.width.equalTo(@(itemWidth));
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(10 *WIDTH_MULTIPLE);
    }];
    
    [_recentViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectStoreLabel.mas_right);
        make.bottom.equalTo(self.collectGoodsLabel);
        make.width.equalTo(@(itemWidth));
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(10 *WIDTH_MULTIPLE);
    }];
}

#pragma mark - action
- (void)labelTapAcion:(UITapGestureRecognizer *)tapGes{
    
    NSInteger tapLableIndex = tapGes.view.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(headerBtnTapIndex:)]) {
        
        [_delegate headerBtnTapIndex:tapLableIndex - 200];
    }
}

#pragma mark - lazyload
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_bg"]];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (UIImageView *)headerImgView{
    
    if (!_headerImgView) {
        
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImgView.clipsToBounds = YES;
        _headerImgView.layer.cornerRadius = 30 * WIDTH_MULTIPLE;
        _headerImgView.layer.borderColor = KAPP_WHITE_COLOR.CGColor;
        _headerImgView.layer.borderWidth = 1;
        _headerImgView.image = [UIImage imageNamed:@"header_placeholder"];
    }
    
    return _headerImgView;
}

- (UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = KFitFont(14);
        _nickNameLabel.textColor = KAPP_WHITE_COLOR;
        _nickNameLabel.text = @"未登录，点我登录";
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nickNameLabel;
}

- (UILabel *)collectGoodsLabel{
    
    if (!_collectGoodsLabel) {
        
        _collectGoodsLabel = [[UILabel alloc] init];
        _collectGoodsLabel.font = KFitFont(12);
        _collectGoodsLabel.textColor = KAPP_WHITE_COLOR;
        _collectGoodsLabel.text = @"0\n收藏的商品";
        _collectGoodsLabel.numberOfLines = 0;
        _collectGoodsLabel.textAlignment = NSTextAlignmentCenter;
        _collectGoodsLabel.tag = 200;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapAcion:)];
        _collectGoodsLabel.userInteractionEnabled = YES;
        [_collectGoodsLabel addGestureRecognizer:tap];
    }
    return _collectGoodsLabel;
}

- (UILabel *)collectStoreLabel{
    
    if (!_collectStoreLabel) {
        
        _collectStoreLabel = [[UILabel alloc] init];
        _collectStoreLabel.font = KFitFont(12);
        _collectStoreLabel.textColor = KAPP_WHITE_COLOR;
        _collectStoreLabel.text = @"0\n收藏的店铺";
        _collectStoreLabel.numberOfLines = 0;
        _collectStoreLabel.textAlignment = NSTextAlignmentCenter;
        _collectStoreLabel.tag = 201;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapAcion:)];
        _collectStoreLabel.userInteractionEnabled = YES;
        [_collectStoreLabel addGestureRecognizer:tap];
    }
    return _collectStoreLabel;
}

- (UILabel *)recentViewLabel{
    
    if (!_recentViewLabel) {
        
        _recentViewLabel = [[UILabel alloc] init];
        _recentViewLabel.font = KFitFont(12);
        _recentViewLabel.textColor = KAPP_WHITE_COLOR;
        _recentViewLabel.text = @"0\n最近浏览";
        _recentViewLabel.numberOfLines = 0;
        _recentViewLabel.textAlignment = NSTextAlignmentCenter;
        _recentViewLabel.tag = 202;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapAcion:)];
        _recentViewLabel.userInteractionEnabled = YES;
        [_recentViewLabel addGestureRecognizer:tap];
    }
    return _recentViewLabel;
}

@end

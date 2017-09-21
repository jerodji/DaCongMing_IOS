//
//  HYProductsImageCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYProductsImageCell.h"

@interface HYProductsImageCell() <SDCycleScrollViewDelegate>

/** banner */
@property (nonatomic,strong) SDCycleScrollView *bannerView;

/** label */
@property (nonatomic,strong) UILabel *titleLabel;


@end

@implementation HYProductsImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _bannerArray = [NSMutableArray array];
        [self addSubview:self.bannerView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
    }];
}

- (void)setBannerArray:(NSMutableArray *)bannerArray{
    
    _bannerArray = bannerArray;
    
    _bannerView.imageURLStringsGroup = bannerArray;
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    NSString *str = [NSString stringWithFormat:@"    %@",title];
    _titleLabel.text = str;
}

#pragma mark - lazyload
- (SDCycleScrollView *)bannerView{
    
    if (!_bannerView) {
        
        //轮播图
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner.jpg"]];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.autoScrollTimeInterval = 2;
        _bannerView.pageDotColor = KAPP_THEME_COLOR;
        _bannerView.autoScroll = YES;
        _bannerView.infiniteLoop = YES;
        _bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _bannerView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(15);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor colorWithRed:(56 / 255.0) green:(57 / 255.0) blue:(56 / 255.0) alpha:0.6];
        _titleLabel.text = @"老挝海林";
        _titleLabel.textColor = KAPP_WHITE_COLOR;
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

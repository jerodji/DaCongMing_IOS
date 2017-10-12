//
//  HYHomeBannerCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeBannerCell.h"
#import "HYBrands.h"

@interface HYHomeBannerCell ()<SDCycleScrollViewDelegate>

/** banner */
@property (nonatomic,strong) SDCycleScrollView *bannerView;

@end

@implementation HYHomeBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _bannerArray = [NSMutableArray array];
        [self addSubview:self.bannerView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (void)setModel:(HYHomePageModel *)model{

    _model = model;
    
    [_bannerArray removeAllObjects];
    
    for (NSDictionary *dict in model.brands) {
        
        HYBrands *brands = [HYBrands modelWithDictionary:dict];
        [_bannerArray addObject:brands.image_url];
    }
    
    _bannerView.imageURLStringsGroup = _bannerArray;
}

- (void)setBannerArray:(NSMutableArray *)bannerArray{
    
    _bannerArray = bannerArray;
    _bannerView.imageURLStringsGroup = _bannerArray;

}


#pragma mark - lazyload
- (SDCycleScrollView *)bannerView{
    
    if (!_bannerView) {
        
        //轮播图
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"shopPlaceholder"]];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.autoScrollTimeInterval = 2;
        _bannerView.pageDotColor = KAPP_THEME_COLOR;
        _bannerView.imageURLStringsGroup = _model.brands;
        _bannerView.autoScroll = YES;
        _bannerView.infiniteLoop = YES;
        _bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _bannerView.contentMode = UIViewContentModeScaleAspectFill;
        _bannerView.clipsToBounds = YES;
    }
    return _bannerView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

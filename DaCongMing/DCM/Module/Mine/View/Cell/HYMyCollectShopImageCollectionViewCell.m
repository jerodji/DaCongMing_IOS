//
//  HYMyCollectShopImageCollectionViewCell.m
//  DaCongMing
//
//

#import "HYMyCollectShopImageCollectionViewCell.h"

@interface HYMyCollectShopImageCollectionViewCell()

/** img */
@property (nonatomic,strong) UIImageView *imgView;
/** 价格 */
@property (nonatomic,strong) UILabel *priceLabel;

@end

@implementation HYMyCollectShopImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.priceLabel];
    [self addSubview:self.imgView];

}

- (void)layoutSubviews{
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(39 * WIDTH_MULTIPLE);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(_priceLabel.mas_top);
    }];
}

#pragma mark - setter
- (void)setItemModel:(HYMyCollectShopItemList *)itemModel{
    
    _itemModel = itemModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:itemModel.item_title_image] placeholderImage:[UIImage imageNamed:@"1x1Placeholder"]];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",itemModel.item_min_price];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
    }
    
    return _imgView;
}


- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.font = KFont(14);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
    
}


@end

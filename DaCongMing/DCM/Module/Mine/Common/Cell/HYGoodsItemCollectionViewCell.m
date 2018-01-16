//
//  HYGoodsItemCollectionViewCell.m
//  DaCongMing
//
//

#import "HYGoodsItemCollectionViewCell.h"
#import "HYAddToCartsHandle.h"

@interface HYGoodsItemCollectionViewCell()

/** img */
@property (nonatomic,strong) UIImageView *imgView;
/** title */
@property (nonatomic,strong) YYLabel *titleLabel;
/** intro */
@property (nonatomic,strong) UILabel *introLabel;
/** price */
@property (nonatomic,strong) UILabel *priceLabel;
/** addShoping */
@property (nonatomic,strong) UIButton *addToShopingCartsBtn;

@end

@implementation HYGoodsItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.introLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.addToShopingCartsBtn];
}

- (void)setGoodsModel:(HYGoodsItemModel *)goodsModel{
    
    _goodsModel = goodsModel;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:goodsModel.item_title_image] placeholderImage:[UIImage imageNamed:@"goodsPlaceholder"]];
    _introLabel.text = ![goodsModel.publicity isNotBlank] ? @"精选自然好货，100%纯天然有机" : goodsModel.publicity;
    
    for (UIView *subViews in self.subviews) {
        
        if (subViews.tag == 999 && [subViews isKindOfClass:[UILabel class]]) {
            
            [subViews removeFromSuperview];
        }
    }
    
    CGFloat labelWidth = [goodsModel.origin widthForFont:KFitFont(12)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth + 8, 15)];
    label.text = goodsModel.origin;
    label.textColor = KAPP_WHITE_COLOR;
    label.backgroundColor = [UIColor blackColor];
    label.layer.cornerRadius = 4;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 999;
    label.font = KFitFont(11);
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *originLabel = [NSMutableAttributedString attachmentStringWithContent:label contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(label.width, label.height) alignToFont:KFitFont(13) alignment:YYTextVerticalAlignmentCenter];
    NSMutableAttributedString *nameAttribute = [[NSMutableAttributedString alloc] initWithString:goodsModel.item_name attributes:@{NSFontAttributeName : KFitFont(14),NSForegroundColorAttributeName : KAPP_272727_COLOR}];
    
    [attributeStr appendAttributedString:originLabel];
    [attributeStr appendString:@" "];
    [attributeStr appendAttributedString:nameAttribute];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4 * WIDTH_MULTIPLE; // 调整行间距
    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributeStr.length)];
    _titleLabel.attributedText = attributeStr;
    
    
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",goodsModel.item_min_price] attributes:@{NSForegroundColorAttributeName : KAPP_PRICE_COLOR, NSFontAttributeName : KFitFont(13)}];
    [priceStr addAttributes:@{NSFontAttributeName : KFitFont(11)} range:NSMakeRange(0, 1)];
    _priceLabel.attributedText = priceStr ;

}

- (void)layoutSubviews{
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(240 * WIDTH_MULTIPLE);
    }];
    
    CGFloat strHeight = [@"哈哈" heightForFont:KFitFont(14) width:KSCREEN_WIDTH];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
<<<<<<< HEAD
        make.left.equalTo(_imgView).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_imgView.mas_bottom).offset(7 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(- 10 * WIDTH_MULTIPLE);
=======
        make.left.equalTo(_priceLabel);
        make.top.equalTo(_priceLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self.contentView).offset(-30 * WIDTH_MULTIPLE);
>>>>>>> 1.1
        make.height.mas_equalTo(strHeight * 2 + 5);
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self).offset(-40);
        make.top.equalTo(_titleLabel.mas_bottom);
        make.height.mas_equalTo(strHeight - 2);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.introLabel);
        make.top.equalTo(self.introLabel.mas_bottom);
        make.height.mas_equalTo(strHeight + 2);
    }];
    
    [_addToShopingCartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-6 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_priceLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(30 * WIDTH_MULTIPLE, 30 * WIDTH_MULTIPLE));
    }];
    
    [self layoutIfNeeded];
<<<<<<< HEAD
    self.goodsModel.cellHeight = self.priceLabel.bottom + 6 * WIDTH_MULTIPLE;
=======
    self.goodsModel.cellHeight = self.introLabel.bottom + 10 * WIDTH_MULTIPLE;
    self.layer.cornerRadius = 5 * WIDTH_MULTIPLE;
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 3.0;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
    self.layer.shouldRasterize = YES;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;    //设置抗锯齿边缘
>>>>>>> 1.1
}

#pragma mark - action
- (void)addToCartsAction{
    
    HYAddToCartsHandle *handle = [[HYAddToCartsHandle alloc] init];
    [handle addToCartsWithProductID:self.goodsModel.item_id];
}

<<<<<<< HEAD
=======
- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self layoutIfNeeded];
    [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height = size.height;
    cellFrame.size.width = itemWidth;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}

>>>>>>> 1.1
#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.image = [UIImage imageNamed:@"header_placeholder"];
    }
    return _imgView;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KFitFont(14);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.text = @"￥0.01";
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}

- (YYLabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.font = KFitFont(10);
        _titleLabel.textColor = KCOLOR(@"272727");
        _titleLabel.text = @"纯天然野猪，野生大象，野生河马，野生哈哈";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    }
    return _titleLabel;
}

- (UILabel *)introLabel{
    
    if (!_introLabel) {
        
        _introLabel = [[UILabel alloc] init];
        _introLabel.font = KFitFont(9);
        _introLabel.textColor = KCOLOR(@"888888");
        _introLabel.text = @"纯野生，纯天然无污染";
        _introLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _introLabel;
}

- (UIButton *)addToShopingCartsBtn{
    
    if (!_addToShopingCartsBtn) {
        
        _addToShopingCartsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToShopingCartsBtn setBackgroundImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
        [_addToShopingCartsBtn addTarget:self action:@selector(addToCartsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToShopingCartsBtn;
}

@end

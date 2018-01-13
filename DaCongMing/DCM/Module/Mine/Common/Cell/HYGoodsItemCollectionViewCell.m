//
//  HYGoodsItemCollectionViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodsItemCollectionViewCell.h"
#import "HYAddToCartsHandle.h"

@interface HYGoodsItemCollectionViewCell()

/** 白色背景 */
@property (nonatomic,strong) UIView *whiteBgView;
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

#define itemWidth (KSCREEN_WIDTH - 15) / 2

@implementation HYGoodsItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
//    [self addSubview:self.whiteBgView]; 
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.introLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.addToShopingCartsBtn];
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
    
    
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",goodsModel.item_min_price] attributes:@{NSForegroundColorAttributeName : KAPP_PRICE_COLOR, NSFontAttributeName : KPriceFont(15)}];
    [priceStr addAttributes:@{NSFontAttributeName : KPriceFont(14)} range:NSMakeRange(0, 1)];
    _priceLabel.attributedText = priceStr ;

}

- (void)layoutSubviews{
    
//    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.edges.equalTo(self);
//    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(@(0));
        make.width.mas_equalTo(itemWidth); // 这里必须给定width的值
        make.bottom.equalTo(_introLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(itemWidth);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.contentView).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self.imgView.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    CGFloat strHeight = [@"哈哈" heightForFont:KFitFont(14) width:KSCREEN_WIDTH];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_priceLabel);
        make.top.equalTo(_priceLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self.contentView).offset(- 10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(strHeight * 2 + 5);
    }];
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self.contentView).offset(-40);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self.contentView).offset(-10 * WIDTH_MULTIPLE);
    }];
    
    [_addToShopingCartsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self.contentView).offset(-6 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(30 * WIDTH_MULTIPLE, 30 * WIDTH_MULTIPLE));
    }];
    
    [self layoutIfNeeded];
    self.goodsModel.cellHeight = self.introLabel.bottom + 10 * WIDTH_MULTIPLE;
    self.layer.cornerRadius = 10 * WIDTH_MULTIPLE;
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 3.0;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
    self.layer.shouldRasterize = YES;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;    //设置抗锯齿边缘
}

#pragma mark - action
- (void)addToCartsAction{
    
    HYAddToCartsHandle *handle = [[HYAddToCartsHandle alloc] init];
    [handle addToCartsWithProductID:self.goodsModel.item_id];
}

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

#pragma mark - lazyload
- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
        _whiteBgView.layer.cornerRadius = 10 * WIDTH_MULTIPLE;
    }
    return _whiteBgView;
}

- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.image = [UIImage imageNamed:@"header_placeholder"];
        _imgView.layer.cornerRadius = self.whiteBgView.layer.cornerRadius;
    }
    return _imgView;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KPriceFont(20);
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.text = @"￥0.01";
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}

- (void)printAllFonts{
    
    NSArray *fontFamilies = [UIFont familyNames];
    int i = 0;
    for(NSString *fontfamilyname in fontFamilies)
    {
        NSLog(@"family:'%@'",fontfamilyname);
        NSArray *fontArray = [UIFont fontNamesForFamilyName:fontfamilyname];
        for(NSString *fontName in fontArray){
            
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------%d",i++);
    }
}

- (YYLabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.font = KFitBoldFont(10);
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
        _introLabel.font = KFitFont(11);
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

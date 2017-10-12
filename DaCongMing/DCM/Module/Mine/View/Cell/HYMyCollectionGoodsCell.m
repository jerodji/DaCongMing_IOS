//
//  HYMyCollectionGoodsCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyCollectionGoodsCell.h"

@interface HYMyCollectionGoodsCell()

/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** 商品图片 */
@property (nonatomic,strong) UIImageView *itemImgView;
/** itemNameLabel */
@property (nonatomic,strong) UILabel *itemLabel;
/** 规格 */
@property (nonatomic,strong) UILabel *unitLabel;
/** 价格 */
@property (nonatomic,strong) UILabel *PriceLabel;

@end


@implementation HYMyCollectionGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        self.backgroundColor = KCOLOR(@"f4f4f4");
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.itemImgView];
    [self addSubview:self.itemLabel];
    [self addSubview:self.unitLabel];
    [self addSubview:self.PriceLabel];
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.right.bottom.equalTo(self);
    }];
    
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(_bgView).offset(5 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-5 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(70 * WIDTH_MULTIPLE);
    }];
    
    [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_itemImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_itemImgView);
        make.height.mas_equalTo(20);
        make.right.equalTo(self);
    }];
    
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_itemLabel.mas_bottom).offset(2 * WIDTH_MULTIPLE);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(250);
    }];
    
    [_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self).offset(-8 * WIDTH_MULTIPLE);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
}

#pragma mark - setter
- (void)setItemModel:(HYGoodsItemModel *)itemModel{
    
    _itemModel = itemModel;
    [_itemImgView sd_setImageWithURL:[NSURL URLWithString:itemModel.item_title_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _itemLabel.text = itemModel.item_name;
    _unitLabel.text = itemModel.item_note;
    _PriceLabel.text = [NSString stringWithFormat:@"￥%@",itemModel.item_min_price];
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UIImageView *)itemImgView{
    
    if (!_itemImgView) {
        
        _itemImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _itemImgView.contentMode = UIViewContentModeScaleAspectFill;
        _itemImgView.clipsToBounds = YES;
        _itemImgView.image = [UIImage imageNamed:@"placeholder"];
    }
    
    return _itemImgView;
}

- (UILabel *)itemLabel{
    
    if (!_itemLabel) {
        
        _itemLabel = [UILabel new];
        _itemLabel.text = @"来自老挝的天然健康产品";
        _itemLabel.textColor = KAPP_272727_COLOR;
        _itemLabel.font = KFitFont(14);
        _itemLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _itemLabel;
}

- (UILabel *)unitLabel{
    
    if (!_unitLabel) {
        
        _unitLabel = [UILabel new];
        _unitLabel.text = @"100g";
        _unitLabel.textColor = KAPP_b7b7b7_COLOR;
        _unitLabel.font = KFitFont(12);
        _unitLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _unitLabel;
}

- (UILabel *)PriceLabel{
    
    if (!_PriceLabel) {
        
        _PriceLabel = [UILabel new];
        _PriceLabel.text = @"$10";
        _PriceLabel.textColor = KAPP_PRICE_COLOR;
        _PriceLabel.font = KFitFont(14);
        _PriceLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _PriceLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

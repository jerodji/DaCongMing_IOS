//
//  HYCartsItemTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/10.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCartsItemTableViewCell.h"

@interface HYCartsItemTableViewCell()

/** 选择 */
@property (nonatomic,strong) UIButton *checkBtn;
/** 商品图片 */
@property (nonatomic,strong) UIImageView *itemImgView;
/** itemNameLabel */
@property (nonatomic,strong) UILabel *itemLabel;
/** countLabel */
@property (nonatomic,strong) UILabel *countLabel;
/** 规格 */
@property (nonatomic,strong) UILabel *unitLabel;
/** 规格 */
@property (nonatomic,strong) UILabel *PriceLabel;
/** line */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYCartsItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.checkBtn];
    [self addSubview:self.itemImgView];
    [self addSubview:self.itemLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.unitLabel];
    [self addSubview:self.PriceLabel];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(20);
    }];
    
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(5 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-5 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(70 * WIDTH_MULTIPLE, 70 * WIDTH_MULTIPLE));
        make.left.equalTo(_checkBtn.mas_right).offset(8 * WIDTH_MULTIPLE);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_itemImgView);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);

    }];
    
    [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_itemImgView);
        make.left.equalTo(_itemImgView.mas_right).offset(6 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20);
        make.right.equalTo(_countLabel.mas_left);
    }];
    
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_itemLabel.mas_bottom).offset(2 * WIDTH_MULTIPLE);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    [_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self).offset(-8 * WIDTH_MULTIPLE);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter
- (void)setItems:(HYCartItems *)items{
    
    _items = items;
    
    [_itemImgView sd_setImageWithURL:[NSURL URLWithString:items.item.item_title_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _itemLabel.text = items.item.item_name;
    _countLabel.text = [NSString stringWithFormat:@"x%@",items.qty];
    _unitLabel.text = items.unit;
    _PriceLabel.text = [NSString stringWithFormat:@"￥%@",items.price];
    _checkBtn.selected = items.isSelect;
}

#pragma mark - action
- (void)checkBtnAction:(UIButton *)button{
    
    button.selected = !button.selected;
}

#pragma mark - lazyload
- (UIButton *)checkBtn{
    
    if (!_checkBtn) {
        
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"selectIcon"] forState:UIControlStateNormal];
        [_checkBtn setImage:[UIImage imageNamed:@"selectIconSelect"] forState:UIControlStateSelected];
        [_checkBtn addTarget:self action:@selector(checkBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
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

- (UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [UILabel new];
        _countLabel.text = @"x1";
        _countLabel.textColor = KAPP_272727_COLOR;
        _countLabel.font = KFitFont(14);
        _countLabel.textAlignment = NSTextAlignmentRight;

    }
    return _countLabel;
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

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

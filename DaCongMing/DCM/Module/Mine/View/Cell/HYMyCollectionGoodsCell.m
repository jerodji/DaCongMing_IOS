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
/** 数量 */
@property (nonatomic,strong) UILabel *countLabel;
/** 选择 */
@property (nonatomic,strong) UIButton *checkBtn;

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
    [self addSubview:self.applySellAfterBtn];
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.left.right.bottom.equalTo(self);
    }];
    
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_bgView).offset(5 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
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
    
    [_applySellAfterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(_itemImgView);
        make.size.mas_equalTo(CGSizeMake(76 * WIDTH_MULTIPLE, 26 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - setter
//收藏商品
- (void)setItemModel:(HYGoodsItemModel *)itemModel{
    
    _itemModel = itemModel;
    [_itemImgView sd_setImageWithURL:[NSURL URLWithString:itemModel.item_title_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _itemLabel.text = itemModel.item_name;
    _unitLabel.text = itemModel.item_note;
    _PriceLabel.text = [NSString stringWithFormat:@"￥%@",itemModel.item_min_price];
    
    if (itemModel.isEdit) {
        
        [self addSubview:self.checkBtn];
        [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(5 * WIDTH_MULTIPLE);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(20 * WIDTH_MULTIPLE);
        }];
        
        [_itemImgView mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).offset(35 * WIDTH_MULTIPLE);
        }];
        
        [self setNeedsUpdateConstraints];
        
    }
    else{
        
        [_checkBtn removeFromSuperview];
        _checkBtn = nil;
        
        [_itemImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        }];
        [self setNeedsUpdateConstraints];

    }
    
}

- (void)setOrderDetailModel:(HYMyOrderDetailsModel *)orderDetailModel{
    
    _orderDetailModel = orderDetailModel;
    [_itemImgView sd_setImageWithURL:[NSURL URLWithString:orderDetailModel.item_title_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _itemLabel.text = orderDetailModel.item_name;
    _unitLabel.text = orderDetailModel.unit;
    _PriceLabel.text = [NSString stringWithFormat:@"￥%@",orderDetailModel.price];
    
    [self addSubview:self.countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_itemLabel);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    _countLabel.text = [NSString stringWithFormat:@"x%@",orderDetailModel.qty];
    
}

#pragma mark - action
- (void)checkBtnAction:(UIButton *)button{
    
    button.selected = !button.selected;
    _itemModel.isSelect = button.selected;
    
    if (self.itemSelect) {
        
        self.itemSelect(button.isSelected);
    }
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

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

- (UIButton *)applySellAfterBtn{
    
    if (!_applySellAfterBtn) {
        
        _applySellAfterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applySellAfterBtn setTitle:@"申请售后" forState:UIControlStateNormal];
        _applySellAfterBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_applySellAfterBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _applySellAfterBtn.titleLabel.font = KFitFont(14);
        _applySellAfterBtn.layer.cornerRadius = 2 * WIDTH_MULTIPLE;
        _applySellAfterBtn.layer.borderColor = KAPP_272727_COLOR.CGColor;
        _applySellAfterBtn.layer.borderWidth = 1;
        _applySellAfterBtn.clipsToBounds = YES;
        [_applySellAfterBtn addTarget:self action:@selector(applySellAfterBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _applySellAfterBtn.hidden = YES;
    }
    return _applySellAfterBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

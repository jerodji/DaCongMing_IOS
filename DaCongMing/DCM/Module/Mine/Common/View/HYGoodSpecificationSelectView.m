//
//  HYGoodSpecificationSelectView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodSpecificationSelectView.h"

#import "HYBuyCountEditView.h"
#import "HYGoodsItemProp.h"

@interface HYGoodSpecificationSelectView()

/** 白色背景 */
@property (nonatomic,strong) UIView *bgView;
/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;
/** price */
@property (nonatomic,strong) UILabel *priceLabel;
/** 库存 */
@property (nonatomic,strong) UILabel *inventoryLabel;
/** line */
@property (nonatomic,strong) UIView *line;
/** 选择规格 */
@property (nonatomic,strong) UILabel *selectSepcLabel;
/** 规格 */
@property (nonatomic,strong) UILabel *speciLabel;
/** 购买数量 */
@property (nonatomic,strong) UILabel *buyCountLabel;
/** 数量控件 */
@property (nonatomic,strong) HYBuyCountEditView *buyCountView;
/** closeBtn */
@property (nonatomic,strong) UIButton *closeBtn;
/** 确定 */
@property (nonatomic,strong) UIButton *confirmBtn;

@end

@implementation HYGoodSpecificationSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
       
            CGPoint tapPoint = [sender locationInView:self];
            if(tapPoint.y < KSCREEN_HEIGHT * 0.5){
                
                [self removeFromSuperview];
            }
            
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.iconImgView];
    [self addSubview:self.priceLabel];
    [self addSubview:self.inventoryLabel];
    [self addSubview:self.selectSepcLabel];
    [self addSubview:self.speciLabel];
    [self addSubview:self.line];
    [self addSubview:self.buyCountLabel];
    [self addSubview:self.buyCountView];
    [self addSubview:self.closeBtn];
    [self addSubview:self.confirmBtn];
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(0.5 * KSCREEN_HEIGHT));
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_bgView.mas_top).offset(-30 * WIDTH_MULTIPLE);
        make.height.width.equalTo(@(100 * WIDTH_MULTIPLE));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_bgView).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_inventoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_priceLabel);
        make.top.equalTo(_priceLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_selectSepcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_priceLabel);
        make.top.equalTo(_inventoryLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [self  layoutIfNeeded];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.top.equalTo(_iconImgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
    }];
    
    [_speciLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(18 * WIDTH_MULTIPLE);
        make.top.equalTo(_line.mas_bottom).offset(9 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_buyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_speciLabel);
        make.top.equalTo(_speciLabel.mas_bottom).offset(80 * WIDTH_MULTIPLE);
        make.width.equalTo(@(80 * WIDTH_MULTIPLE));
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_buyCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_buyCountLabel.mas_right);
        make.top.equalTo(_speciLabel.mas_bottom).offset(80 * WIDTH_MULTIPLE);
        make.width.equalTo(@(120 * WIDTH_MULTIPLE));
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(_bgView);
        make.height.equalTo(@(50));
    }];
}

- (void)setGoodsModel:(HYGoodsDetailModel *)goodsModel{
    
    _goodsModel = goodsModel;
    for (NSDictionary *dict in goodsModel.item_prop) {
        
        HYGoodsItemProp *specificationModel = [HYGoodsItemProp modelWithDictionary:dict];
        [self.specificationUnitArray addObject:specificationModel.unit];
    }
    
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.item_title_image] placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
    NSDictionary *dict =  _goodsModel.item_prop[0];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"price"]];
    
}

#pragma mark - action
- (void)confirmAction{
    
    
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
        _bgView.tag = 100;
        _bgView.userInteractionEnabled = NO;
    }
    return _bgView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.clipsToBounds = YES;
        _iconImgView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _iconImgView.layer.borderColor = KAPP_WHITE_COLOR.CGColor;
        _iconImgView.layer.borderWidth = 2;
        _iconImgView.image = [UIImage imageNamed:@"header_placeholder"];
    }
    
    return _iconImgView;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KFitFont(18);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.text = @"￥9999";
    }
    return _priceLabel;
}

- (UILabel *)inventoryLabel{
    
    if (!_inventoryLabel) {
        
        _inventoryLabel = [[UILabel alloc] init];
        _inventoryLabel.font = KFitFont(14);
        _inventoryLabel.textAlignment = NSTextAlignmentLeft;
        _inventoryLabel.textColor = KAPP_272727_COLOR;
        _inventoryLabel.text = @"库存:10000";
    }
    return _inventoryLabel;
}

- (UILabel *)selectSepcLabel{
    
    if (!_selectSepcLabel) {
        
        _selectSepcLabel = [[UILabel alloc] init];
        _selectSepcLabel.font = KFitFont(14);
        _selectSepcLabel.textAlignment = NSTextAlignmentLeft;
        _selectSepcLabel.textColor = KAPP_272727_COLOR;
        _selectSepcLabel.text = @"选择 规格 数量";
    }
    return _selectSepcLabel;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [UIView new];
        _line.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _line;
}

- (UILabel *)speciLabel{
    
    if (!_speciLabel) {
        
        _speciLabel = [[UILabel alloc] init];
        _speciLabel.font = KFitFont(14);
        _speciLabel.textAlignment = NSTextAlignmentLeft;
        _speciLabel.textColor = KAPP_272727_COLOR;
        _speciLabel.text = @"规格";
    }
    return _speciLabel;
}

- (UILabel *)buyCountLabel{
    
    if (!_buyCountLabel) {
        
        _buyCountLabel = [[UILabel alloc] init];
        _buyCountLabel.font = KFitFont(14);
        _buyCountLabel.textAlignment = NSTextAlignmentLeft;
        _buyCountLabel.textColor = KAPP_272727_COLOR;
        _buyCountLabel.text = @"购买数量";
    }
    return _buyCountLabel;
}

- (HYBuyCountEditView *)buyCountView{
    
    if (!_buyCountView) {
        
        _buyCountView = [HYBuyCountEditView new];
    }
    return _buyCountView;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (NSMutableArray *)specificationUnitArray{
    
    if (!_specificationUnitArray) {
        _specificationUnitArray = [NSMutableArray array];
    }
    return _specificationUnitArray;
}

@end

//
//  HYGoodSpecificationSelectView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/21.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodSpecificationSelectView.h"

#import "HYBuyCountEditView.h"

@interface HYGoodSpecificationSelectView()

/** 半透明背景 */
@property (nonatomic,strong) UIView *blackBgView;
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


/** 规格起始高度 */
@property (nonatomic,assign) CGFloat startY;
/** 规格截止高度 */
@property (nonatomic,assign) CGFloat endY;
/** 记录上一次点击的规格按钮 */
@property (nonatomic,strong) UIButton *previousSelectBtn;
/** 记录上一次点击的规格的model */
@property (nonatomic,strong) HYGoodsItemProp *previousItemModel;
/** 记录购买数量 */
@property (nonatomic,assign) NSInteger buyCountNum;

@end

@implementation HYGoodSpecificationSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
       
            CGPoint tapPoint = [sender locationInView:self];
            if(tapPoint.y < KSCREEN_HEIGHT * 0.6){
                
                [self hideGoodsSpecificationView];
            }
            
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.blackBgView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.iconImgView];
    [self.bgView addSubview:self.priceLabel];
    [self.bgView addSubview:self.inventoryLabel];
    [self.bgView addSubview:self.selectSepcLabel];
    [self.bgView addSubview:self.speciLabel];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.buyCountLabel];
    [self.bgView addSubview:self.buyCountView];
    [self.bgView addSubview:self.closeBtn];
    [self.bgView addSubview:self.confirmBtn];
    
    [self buyCountChanged];
}

- (void)buyCountChanged{
    
    __weak typeof (self)weakSelf = self;
    self.buyCountView.countCallback = ^(NSInteger count) {
        
        weakSelf.buyCountNum = count;
        weakSelf.selectSepcLabel.text = [NSString stringWithFormat:@"%@  x  %ld",weakSelf.previousItemModel.unit,(long)weakSelf.buyCountNum];
    };
}

- (void)layoutSubviews{
    
    [self setupSubviews];

    [_blackBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self);
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
    
    [self layoutIfNeeded];
    _startY = _speciLabel.bottom + 20;
    
    [_buyCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_speciLabel);
        make.top.equalTo(@(_endY + 15));
        make.width.equalTo(@(80 * WIDTH_MULTIPLE));
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
    }];
    
    [_buyCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_buyCountLabel.mas_right);
        make.top.equalTo(_buyCountLabel);
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
    
    [_specificationUnitArray removeAllObjects];
    for (NSDictionary *dict in goodsModel.item_prop) {
        
        HYGoodsItemProp *specificationModel = [HYGoodsItemProp modelWithDictionary:dict];
        [self.specificationUnitArray addObject:specificationModel];
    }
    
    [self layoutIfNeeded];
    [self createSpecificationButtonWithArray:_specificationUnitArray];
    
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_goodsModel.item_title_image] placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
    NSDictionary *dict =  _goodsModel.item_prop[0];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"price"]];
    
}

//创建规格按钮
- (void)createSpecificationButtonWithArray:(NSArray *)array{
    
    //保存前一个button的宽，以及前一个button到屏幕的距离
    CGFloat w = 26 * WIDTH_MULTIPLE;
    CGFloat h = _startY ;      //用来保存button距离父视图的高
    
    //移除button
    for (UIView *subView in self.subviews) {
        
        if (subView.tag >= 1000) {
            
            [subView removeFromSuperview];
        }
    }
    
    if (array.count) {
        for (NSInteger i = 0; i < array.count; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.layer.cornerRadius = 3;
            button.layer.masksToBounds = YES;
            [button setBackgroundImage:[UIImage imageWithColor:KCOLOR(@"f5f5f5")] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageWithColor:KAPP_THEME_COLOR] forState:UIControlStateSelected];
            [button setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateSelected];
            [button setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
            button.titleLabel.font = KFitFont(14);
            [button addTarget:self action:@selector(specificationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            button.highlighted = NO;
            button.tag = 1000 + i;
            
            HYGoodsItemProp *model = model = array[i];
            NSString *itemUnit = model.unit;
            
            [button setTitle:itemUnit forState:UIControlStateNormal];
            CGFloat itemWidth = [itemUnit widthForFont:KFitFont(14)] + 40;
            
            button.frame = CGRectMake(w, h, itemWidth, 30);
            w = w + itemWidth + 20;
            //如果button的位置超过屏幕边缘就换行
            if (w > KSCREEN_WIDTH - 40) {
                w = 26 * WIDTH_MULTIPLE;
                h = h + button.height + 20;
                //重设button的frame
                button.frame = CGRectMake(w, h, itemWidth, 30);
            }
            
            _endY = button.bottom + 10;
            [self.bgView addSubview:button];
        }
    }
    
    [_buyCountLabel layoutIfNeeded];
}

#pragma mark - action
- (void)confirmAction{
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(confirmGoodsSpeciSelectWithModel:buyCount:)]) {
        
        [_delegate confirmGoodsSpeciSelectWithModel:_previousItemModel buyCount:_buyCountNum];
    }
}

- (void)specificationBtnAction:(UIButton *)button{
    
    _previousSelectBtn.selected = NO;
    button.selected = YES;
    _previousSelectBtn = button;
    
    HYGoodsItemProp *item = _specificationUnitArray[button.tag - 1000];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",item.price];
    _inventoryLabel.text = [NSString stringWithFormat:@"库存:%@",item.qty];
    
    if (!_buyCountNum) {
        _buyCountNum = 1;
    }
    _selectSepcLabel.text = [NSString stringWithFormat:@"%@  x  %ld",item.unit,(long)_buyCountNum];
    
    _previousItemModel = item;
}

#pragma mark - publicMethod
- (void)showGoodsSpecificationView{
    
    [self setupSubviews];
    [UIView animateWithDuration:0.25 animations:^{
        
        _blackBgView.alpha = 0.6;
        _bgView.frame = CGRectMake(0, 0.5 * KSCREEN_HEIGHT, KSCREEN_WIDTH, 0.5 * KSCREEN_HEIGHT);
    }];
}

- (void)hideGoodsSpecificationView{
    
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}

#pragma mark - lazyload
- (UIView *)blackBgView{
    
    if (!_blackBgView) {
        
        _blackBgView = [UIView new];
        _blackBgView.backgroundColor = KAPP_BLACK_COLOR;
        _blackBgView.alpha = 0;
    }
    return _blackBgView;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT * 0.5)];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
        _bgView.tag = 100;
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

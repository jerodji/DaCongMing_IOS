//
//  HYGoodsPostageTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYGoodsPostageTableViewCell.h"

@interface HYGoodsPostageTableViewCell()

/** 商品总数 */
@property (nonatomic,strong) UILabel *goodsCountLabel;
/** 邮费总计 */
@property (nonatomic,strong) UILabel *postageLabel;
/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** 邮费价格 */
@property (nonatomic,strong) UILabel *postagePriceLabel;
/** 99包邮 */
@property (nonatomic,strong) UIButton *freePostageBtn;
/** 查看 */
@property (nonatomic,strong) UIButton *lookInfoBtn;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYGoodsPostageTableViewCell

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
    
    [self addSubview:self.goodsCountLabel];
    [self addSubview:self.postageLabel];
    [self addSubview:self.bgView];
    [self addSubview:self.postagePriceLabel];
//    [self addSubview:self.freePostageBtn];
    [self addSubview:self.lookInfoBtn];
    [self addSubview:self.bottomLine];
    
    self.lookInfoBtn.hidden = YES;
}

#pragma mark - setter
- (void)setOrderModel:(HYCreateOrder *)orderModel{
    
    _orderModel = orderModel;
    NSString *str = [NSString stringWithFormat:@"共%@件商品 ",orderModel.summary_qty];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_PRICE_COLOR} range:NSMakeRange(1, 1)];
    _goodsCountLabel.attributedText = attributeStr;
    
    for (UIView *subView in self.subviews) {
        if (subView.tag >= 1000) {
            [subView removeFromSuperview];
        }
    }
    
    //创建img
    for (NSInteger i = 0; i < orderModel.item_imageList.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(20 * WIDTH_MULTIPLE + i * 70 * WIDTH_MULTIPLE, _bgView.top + 10 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE);
        [imgView sd_setImageWithURL:[NSURL URLWithString:orderModel.item_imageList[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = 1000 + i;
        [self addSubview:imgView];
    }
}

- (void)layoutSubviews{
    
    [_goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self);
        make.height.mas_equalTo(25 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_goodsCountLabel.mas_bottom).offset(5 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
    }];
    
    [_postageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_goodsCountLabel);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
        make.width.equalTo(@(150));
    }];
    
    CGFloat priceLabelWidth = [@"￥0.00" widthForFont:KFitFont(15)];
    [_postagePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self);
        make.top.equalTo(_postageLabel);
        make.width.equalTo(@(priceLabelWidth + 20));
    }];
    
//    [_freePostageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.bottom.height.equalTo(_postageLabel);
//        make.width.equalTo(@(100 * WIDTH_MULTIPLE));
//        make.right.equalTo(_postagePriceLabel.mas_left);
//    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [_lookInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(_bgView);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
}

#pragma mark - lazyload
- (UILabel *)goodsCountLabel{
    
    if (!_goodsCountLabel) {
        
        _goodsCountLabel = [[UILabel alloc] init];
        _goodsCountLabel.font = KFitFont(15);
        _goodsCountLabel.textAlignment = NSTextAlignmentLeft;
        _goodsCountLabel.text = @"共一件商品";
        _goodsCountLabel.textColor = KAPP_7b7b7b_COLOR;
    }
    return _goodsCountLabel;
}

- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KCOLOR(@"f1f5f3");
    }
    return _bgView;
}

- (UILabel *)postageLabel{
    
    if (!_postageLabel) {
        
        _postageLabel = [[UILabel alloc] init];
        _postageLabel.font = KFitFont(15);
        _postageLabel.textAlignment = NSTextAlignmentLeft;
        _postageLabel.text = @"快递邮费总计";
        _postageLabel.textColor = KAPP_272727_COLOR;
    }
    return _postageLabel;
}

- (UILabel *)postagePriceLabel{
    
    if (!_postagePriceLabel) {
        
        _postagePriceLabel = [[UILabel alloc] init];
        _postagePriceLabel.font = KFitFont(15);
        _postagePriceLabel.textAlignment = NSTextAlignmentRight;
        _postagePriceLabel.text = @"￥0.00";
        _postagePriceLabel.textColor = KAPP_272727_COLOR;
    }
    return _postagePriceLabel;
}

- (UIButton *)freePostageBtn{
    
    if (!_freePostageBtn) {
        
        _freePostageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_freePostageBtn setBackgroundImage:[UIImage imageNamed:@"order_postageBg"] forState:UIControlStateNormal];
        [_freePostageBtn setTitle:@"满99包邮" forState:UIControlStateNormal];
        _freePostageBtn.titleLabel.font = KFitFont(12);
        [_freePostageBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    return _freePostageBtn;
}

- (UIButton *)lookInfoBtn{
    
    if (!_lookInfoBtn) {
        
        _lookInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookInfoBtn setImage:[UIImage imageNamed:@"order_arrow"] forState:UIControlStateNormal];
        [_lookInfoBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_lookInfoBtn setTitleColor:KAPP_7b7b7b_COLOR forState:UIControlStateNormal];
        _lookInfoBtn.titleLabel.font = KFitFont(12);
        UIImage *image = _lookInfoBtn.imageView.image;
        [_lookInfoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width - 15, 0, image.size.width + 15)];
        [_lookInfoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _lookInfoBtn.titleLabel.bounds.size.width + 5, 0, -_lookInfoBtn.titleLabel.bounds.size.width - 5)];
        _lookInfoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _lookInfoBtn;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

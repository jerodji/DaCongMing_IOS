//
//  HYMyOrderTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyOrderTableViewCell.h"

@interface HYMyOrderTableViewCell()

/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;
/** shopLabel */
@property (nonatomic,strong) UILabel *shopLabel;
/** 订单 */
@property (nonatomic,strong) UILabel *orderIDLabel;
/** 商品总数 */
@property (nonatomic,strong) UILabel *goodsCountLabel;
/** topLine */
@property (nonatomic,strong) UIView *topLine;
/** middleLine */
@property (nonatomic,strong) UIView *middleLine;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;
/** pricelabel */
@property (nonatomic,strong) UILabel *priceLabel;
/** 再次购买 */
@property (nonatomic,strong) UIButton *buyAgainBtn;
/** 删除订单 */
@property (nonatomic,strong) UIButton *deleteOrderBtn;
/** 去付款 */
@property (nonatomic,strong) UIButton *toPayBtn;
/** 确认收货 */
@property (nonatomic,strong) UIButton *confirmGoodsBtn;

@end

@implementation HYMyOrderTableViewCell

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
    
    [self addSubview:self.iconImgView];
    [self addSubview:self.shopLabel];
    [self addSubview:self.orderIDLabel];
    [self addSubview:self.goodsCountLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.middleLine];
    [self addSubview:self.priceLabel];
    [self addSubview:self.buyAgainBtn];
    [self addSubview:self.toPayBtn];
    [self addSubview:self.confirmGoodsBtn];
    [self addSubview:self.deleteOrderBtn];
    [self addSubview:self.topLine];

}

- (void)layoutSubviews{
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(5 * WIDTH_MULTIPLE);
        make.width.height.equalTo(@20);
    }];
    
    [_orderIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(_iconImgView);
        make.width.equalTo(@(190 * WIDTH_MULTIPLE));
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImgView.mas_right).offset(6 * WIDTH_MULTIPLE);
        make.centerY.equalTo(_iconImgView);
        make.right.equalTo(_orderIDLabel.mas_left);
        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImgView);
        make.right.equalTo(_orderIDLabel);
        make.height.mas_equalTo(1);
        make.top.equalTo(self).offset(30 * WIDTH_MULTIPLE);
    }];
    
    
    [_buyAgainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self).offset(-14 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-12 * WIDTH_MULTIPLE);
        make.width.equalTo(@(74 * WIDTH_MULTIPLE));
        make.height.equalTo(@(26 * WIDTH_MULTIPLE));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
        make.bottom.equalTo(self).offset(-50 * WIDTH_MULTIPLE);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
        make.bottom.equalTo(_bottomLine);
        make.width.equalTo(@(90 * WIDTH_MULTIPLE));
    }];
    
    [_goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_priceLabel.mas_left);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
        make.bottom.equalTo(_bottomLine);
        make.width.equalTo(@(180 * WIDTH_MULTIPLE));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(_topLine);
        make.height.equalTo(@1);
        make.bottom.equalTo(_bottomLine.mas_top).offset(-40 * WIDTH_MULTIPLE);
    }];
    
    [_toPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.bottom.equalTo(_buyAgainBtn);
    }];
    
    [_confirmGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.equalTo(_buyAgainBtn);
    }];
    
    [_deleteOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_confirmGoodsBtn.mas_left).offset(-14 * WIDTH_MULTIPLE);
        make.top.bottom.width.equalTo(_confirmGoodsBtn);
    }];
}

#pragma mark - getter
- (void)setModel:(HYMyOrderModel *)model{
    
    _model = model;
    _shopLabel.text = model.seller_name;
    _goodsCountLabel.text = [NSString stringWithFormat:@"共%@件商品",model.summary_qty];
    _orderIDLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.sorder_id];
    NSString *priceStr = [NSString stringWithFormat:@"实付 %@",model.summary_price];
    NSMutableAttributedString *attributesStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attributesStr addAttribute:NSForegroundColorAttributeName value:KAPP_272727_COLOR range:NSMakeRange(0, 3)];
    _priceLabel.attributedText = attributesStr;
    
    [self createOrderImageWithArray:model.orderDtls];
    
    NSInteger state = [model.order_stat integerValue];
    //未付款：1、待发货（已付款）：2、待收货：3、已收货：8
    switch (state) {
        case 1:
            _confirmGoodsBtn.hidden = YES;
            _deleteOrderBtn.hidden = YES;
            _buyAgainBtn.hidden = YES;
            _toPayBtn.hidden = NO;
            break;
        case 2:
            _confirmGoodsBtn.hidden = NO;
            _deleteOrderBtn.hidden = NO;
            _buyAgainBtn.hidden = YES;
            _toPayBtn.hidden = YES;
            break;
        case 3:
            _confirmGoodsBtn.hidden = NO;
            _deleteOrderBtn.hidden = YES;
            _buyAgainBtn.hidden = YES;
            _toPayBtn.hidden = YES;
            break;
        case 8:
            _confirmGoodsBtn.hidden = YES;
            _deleteOrderBtn.hidden = NO;
            _buyAgainBtn.hidden = NO;
            _toPayBtn.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)createOrderImageWithArray:(NSArray *)array{
    
    UIImageView *tempImageView = nil;
    for (UIView *subView in self.subviews) {
        
        if (subView.tag >= 900 && [subView isKindOfClass:[UIImageView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < array.count; i++) {

        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        NSDictionary *dict = array[i];
        [imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"item_title_image"]] placeholderImage:[UIImage imageNamed:@"order_placeholder"]];
        [self addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(_topLine).offset(10 * WIDTH_MULTIPLE);
            make.size.mas_equalTo(CGSizeMake(66 * WIDTH_MULTIPLE, 80 * WIDTH_MULTIPLE));
            
            if (tempImageView) {
                
                make.left.equalTo(tempImageView.mas_right).offset(18 * WIDTH_MULTIPLE);
            }
            else{
                make.left.equalTo(_iconImgView);
            }
        }];
        tempImageView = imgView;
        imgView.tag = 900 + i;
    }
    
    tempImageView = nil;
}

#pragma mark - action
- (void)toPayAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(myOrderBtnActionWithStr:WithIndexPath:)]) {
        
        [_delegate myOrderBtnActionWithStr:@"去付款" WithIndexPath:self.indexPath];
    }
}

- (void)buyAgainAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(myOrderBtnActionWithStr:WithIndexPath:)]) {
        
        [_delegate myOrderBtnActionWithStr:@"再次购买" WithIndexPath:self.indexPath];
    }
}

- (void)confirmAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(myOrderBtnActionWithStr:WithIndexPath:)]) {
        
        [_delegate myOrderBtnActionWithStr:@"确认收货" WithIndexPath:self.indexPath];
    }
}

- (void)deleteOrderAction{
    
    if (_delegate && [_delegate respondsToSelector:@selector(myOrderBtnActionWithStr:WithIndexPath:)]) {
        
        [_delegate myOrderBtnActionWithStr:@"删除订单" WithIndexPath:self.indexPath];
    }
}

#pragma mark - lazyload
- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shop"]];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UILabel *)shopLabel{
    
    if (!_shopLabel) {
        
        _shopLabel = [[UILabel alloc] init];
        _shopLabel.font = KFitFont(13);
        _shopLabel.textAlignment = NSTextAlignmentLeft;
        _shopLabel.text = @"海林官方旗舰店";
        _shopLabel.textColor = KAPP_272727_COLOR;
        
    }
    return _shopLabel;
}

- (UILabel *)orderIDLabel{
    
    if (!_orderIDLabel) {
        
        _orderIDLabel = [[UILabel alloc] init];
        _orderIDLabel.font = KFitFont(11);
        _orderIDLabel.textAlignment = NSTextAlignmentRight;
        _orderIDLabel.text = @"海林官方旗舰店";
        _orderIDLabel.adjustsFontSizeToFitWidth = YES;
        _orderIDLabel.textColor = KAPP_272727_COLOR;
    }
    return _orderIDLabel;
}

- (UILabel *)goodsCountLabel{
    
    if (!_goodsCountLabel) {
        
        _goodsCountLabel = [[UILabel alloc] init];
        _goodsCountLabel.font = KFitFont(14);
        _goodsCountLabel.textAlignment = NSTextAlignmentRight;
        _goodsCountLabel.text = @"海林官方旗舰店";
        _goodsCountLabel.textColor = KAPP_272727_COLOR;
    }
    return _goodsCountLabel;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = KAPP_SEPERATOR_COLOR;
        
        _middleLine = [[UIView alloc] init];
        _middleLine.backgroundColor = KAPP_SEPERATOR_COLOR;
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = KFitFont(14);
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"实付 ￥0.00";
        _priceLabel.textColor = KAPP_PRICE_COLOR;
    }
    return _priceLabel;
}

- (UIButton *)buyAgainBtn{
    
    if (!_buyAgainBtn) {
        
        _buyAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyAgainBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        _buyAgainBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_buyAgainBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _buyAgainBtn.titleLabel.font = KFitFont(14);
        _buyAgainBtn.layer.cornerRadius = 2 * WIDTH_MULTIPLE;
        _buyAgainBtn.layer.borderColor = KAPP_272727_COLOR.CGColor;
        _buyAgainBtn.layer.borderWidth = 1;
        _buyAgainBtn.clipsToBounds = YES;
        [_buyAgainBtn addTarget:self action:@selector(buyAgainAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyAgainBtn;
}

- (UIButton *)toPayBtn{
    
    if (!_toPayBtn) {
        
        _toPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_toPayBtn setTitle:@"去付款" forState:UIControlStateNormal];
        _toPayBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_toPayBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _toPayBtn.titleLabel.font = KFitFont(14);
        _toPayBtn.layer.cornerRadius = 2 * WIDTH_MULTIPLE;
        _toPayBtn.layer.borderColor = KAPP_272727_COLOR.CGColor;
        _toPayBtn.layer.borderWidth = 1;
        _toPayBtn.clipsToBounds = YES;
        [_toPayBtn addTarget:self action:@selector(toPayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toPayBtn;
}

- (UIButton *)deleteOrderBtn{
    
    if (!_deleteOrderBtn) {
        
        _deleteOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        _deleteOrderBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_deleteOrderBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _deleteOrderBtn.titleLabel.font = KFitFont(14);
        _deleteOrderBtn.layer.cornerRadius = 2 * WIDTH_MULTIPLE;
        _deleteOrderBtn.layer.borderColor = KAPP_272727_COLOR.CGColor;
        _deleteOrderBtn.layer.borderWidth = 1;
        _deleteOrderBtn.clipsToBounds = YES;
        [_deleteOrderBtn addTarget:self action:@selector(deleteOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteOrderBtn;
}

- (UIButton *)confirmGoodsBtn{
    
    if (!_confirmGoodsBtn) {
        
        _confirmGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmGoodsBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        _confirmGoodsBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_confirmGoodsBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _confirmGoodsBtn.titleLabel.font = KFitFont(14);
        _confirmGoodsBtn.layer.cornerRadius = 2 * WIDTH_MULTIPLE;
        _confirmGoodsBtn.layer.borderColor = KAPP_272727_COLOR.CGColor;
        _confirmGoodsBtn.layer.borderWidth = 1;
        _confirmGoodsBtn.clipsToBounds = YES;
        [_confirmGoodsBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmGoodsBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

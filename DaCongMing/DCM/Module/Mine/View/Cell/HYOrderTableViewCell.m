//
//  HYOrderTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYOrderTableViewCell.h"

@interface HYOrderTableViewCell()

/** label */
@property (nonatomic,strong) UILabel *orderLabel;
/** order */
@property (nonatomic,strong) UIButton *myOrderBtn;
/** 售后 */
@property (nonatomic,strong) UIButton *afterSaleBtn;
/** horizontalLine */
@property (nonatomic,strong) UIView *horizontalLine;
/** line */
@property (nonatomic,strong) UIView *verticalLine;

@end

@implementation HYOrderTableViewCell

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

#pragma mark - UI
- (void)setupSubviews{
    
    [self addSubview:self.orderLabel];
    [self addSubview:self.horizontalLine];
    [self addSubview:self.myOrderBtn];
    [self addSubview:self.afterSaleBtn];
    [self addSubview:self.verticalLine];
}

- (void)layoutSubviews{

    CGFloat itemWidth = self.width / 2;
    
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self).offset(20);
        make.height.equalTo(@(30 * WIDTH_MULTIPLE));
        
    }];
    
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self.orderLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_myOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self);
        make.width.equalTo(@(itemWidth));
        make.top.equalTo(self.horizontalLine);
        make.height.equalTo(@(50 * WIDTH_MULTIPLE));
    }];
    
    [_afterSaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.myOrderBtn.mas_right);
        make.width.equalTo(@(itemWidth));
        make.top.equalTo(self.horizontalLine);
        make.height.equalTo(@(50 * WIDTH_MULTIPLE));
    }];
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.horizontalLine);
        make.bottom.equalTo(self);
        make.width.equalTo(@1);
        make.centerX.equalTo(self);
    }];
}


#pragma mark - action
- (void)myOrderAction{

}

- (void)afterSaleAction{
    
}

#pragma mark - lazyload
- (UILabel *)orderLabel{
    
    if (!_orderLabel) {
        
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.font = KFitFont(13);
        _orderLabel.textColor = KCOLOR(@"272727");
        _orderLabel.text = @"订单";
        _orderLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _orderLabel;
}

- (UIView *)horizontalLine{
    
    if (!_horizontalLine) {
        
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.backgroundColor = KCOLOR(@"e9e9e9");
    }
    return _horizontalLine;
}

- (UIView *)verticalLine{
    
    if (!_verticalLine) {
        
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = KCOLOR(@"e9e9e9");
    }
    return _verticalLine;
}

- (UIButton *)myOrderBtn{

    if (!_myOrderBtn) {
        _myOrderBtn = [[UIButton alloc] init];
        [_myOrderBtn setTitle:@"我的订单" forState:UIControlStateNormal];
        [_myOrderBtn setImage:[UIImage imageNamed:@"mine_myOrder"] forState:UIControlStateNormal];
        [_myOrderBtn setTitleColor:KCOLOR(@"272727") forState:UIControlStateNormal];
        _myOrderBtn.titleLabel.font = KFitFont(14);
        _myOrderBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
        [_myOrderBtn addTarget:self action:@selector(myOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myOrderBtn;
}

- (UIButton *)afterSaleBtn{
    
    if (!_afterSaleBtn) {
        _afterSaleBtn = [[UIButton alloc] init];
        [_afterSaleBtn setTitle:@"售后及退款服务" forState:UIControlStateNormal];
        [_afterSaleBtn setImage:[UIImage imageNamed:@"mine_afterSale"] forState:UIControlStateNormal];
        [_afterSaleBtn setTitleColor:KCOLOR(@"272727") forState:UIControlStateNormal];
        _afterSaleBtn.titleLabel.font = KFitFont(14);
        _afterSaleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);

        [_afterSaleBtn addTarget:self action:@selector(afterSaleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _afterSaleBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

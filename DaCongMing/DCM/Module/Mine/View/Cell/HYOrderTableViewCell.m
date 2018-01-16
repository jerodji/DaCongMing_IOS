//
//  HYOrderTableViewCell.m
//  DaCongMing
//
//

#import "HYOrderTableViewCell.h"

@interface HYOrderTableViewCell()

/** label */
@property (nonatomic,strong) UILabel *orderLabel;
/** lookAllOrderBtn */
@property (nonatomic,strong) UIButton *lookAllOrderBtn;
/** horizontalLine */
@property (nonatomic,strong) UIView *horizontalLine;
/** line */
@property (nonatomic,strong) UIView *verticalLine;

/** imgArray */
@property (nonatomic,copy) NSArray *imgArray;
/** titleArray */
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation HYOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleArray = @[@"待付款",@"待发货",@"待收货",@"已收货",@"售后服务"];
        _imgArray = @[@"mine_waitPayment",@"mine_wait_deliever",@"mine_wait_takeDelievery",@"mine_delievery",@"mine_aftersaleService"];
        
         [self setupSubviews];
    }
    return self;
}

#pragma mark - UI
- (void)setupSubviews{
    
    [self addSubview:self.orderLabel];
    [self addSubview:self.horizontalLine];
    [self addSubview:self.verticalLine];
    [self addSubview:self.lookAllOrderBtn];
    
    CGFloat itemWidth = KSCREEN_WIDTH  / 5;
    CGFloat itemHeight = 50 * WIDTH_MULTIPLE;
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        
        HYButton *button = [HYButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_imgArray[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(i * itemWidth,  50 * WIDTH_MULTIPLE, itemWidth, itemHeight);
        button.titleLabel.font = KFitFont(14);
        [button setTitleColor:KCOLOR(@"272727") forState:UIControlStateNormal];
        [self addSubview:button];
        button.tag = 300 + i;
        [button addTarget:self action:@selector(orderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)layoutSubviews{

    
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self);
        make.height.equalTo(@(40 * WIDTH_MULTIPLE));
        
    }];
    
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(self.orderLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [_lookAllOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.height.equalTo(_orderLabel);
        make.right.equalTo(self);
        make.width.equalTo(@(160));
    }];
}


#pragma mark - action
- (void)orderBtnAction:(UIButton *)button{

    if (_delegate && [_delegate respondsToSelector:@selector(jumpToMyOrderDetailVCWithTag:)]) {
        
        [_delegate jumpToMyOrderDetailVCWithTag:button.tag - 300];
    }
}

- (void)myOrderAction{
    
    self.myAllOrder();
}

#pragma mark - lazyload
- (UILabel *)orderLabel{
    
    if (!_orderLabel) {
        
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.font = KFitFont(15);
        _orderLabel.textColor = KCOLOR(@"272727");
        _orderLabel.text = @"我的订单";
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


- (UIButton *)lookAllOrderBtn{
    
    if (!_lookAllOrderBtn) {
        
        _lookAllOrderBtn = [[UIButton alloc] init];
        [_lookAllOrderBtn setTitle:@"查看全部订单" forState:UIControlStateNormal];
        [_lookAllOrderBtn setImage:[UIImage imageNamed:@"order_arrow"] forState:UIControlStateNormal];
        [_lookAllOrderBtn setTitleColor:KAPP_b7b7b7_COLOR forState:UIControlStateNormal];
        _lookAllOrderBtn.titleLabel.font = KFitFont(14);
        
        UIImage *image = _lookAllOrderBtn.imageView.image;
        [_lookAllOrderBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width - 2, 0, image.size.width + 2)];
        CGFloat strWidth = [@"查看全部订单" widthForFont:KFitFont(14)];
        [_lookAllOrderBtn setImageEdgeInsets:UIEdgeInsetsMake(0, strWidth + 2, 0, -strWidth - 2)];
        
        
        [_lookAllOrderBtn addTarget:self action:@selector(myOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookAllOrderBtn;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

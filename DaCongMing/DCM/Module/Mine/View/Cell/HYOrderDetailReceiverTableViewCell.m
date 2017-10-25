//
//  HYOrderDetailReceiverTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYOrderDetailReceiverTableViewCell.h"

@interface HYOrderDetailReceiverTableViewCell()

/** 物流车 */
@property (nonatomic,strong) UIImageView *logisticsCarImgView;
/** 箭头 */
@property (nonatomic,strong) UIImageView *arrowImgView;
/** 收货人 */
@property (nonatomic,strong) UILabel *receiverInfoLabel;
/** line */
@property (nonatomic,strong) UIView *line;
/** infoView */
@property (nonatomic,strong) UIView *orderInfoView;

@end

@implementation HYOrderDetailReceiverTableViewCell

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
    
    [self addSubview:self.logisticsCarImgView];
    [self addSubview:self.receiverInfoLabel];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.line];
    
    self.arrowImgView.hidden = YES;
    
}

- (void)layoutSubviews{
    
    [_logisticsCarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(30 / 1.77));
        make.centerY.equalTo(self);
        make.height.equalTo(@(30));
    }];
    
    [_receiverInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_logisticsCarImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(_arrowImgView.mas_left).offset(30 * WIDTH_MULTIPLE);
        make.top.bottom.equalTo(self);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter
- (void)setOrderModel:(HYMyOrderModel *)orderModel{
    
    _orderModel = orderModel;
    
    if ([orderModel.express_msg isNotBlank]) {
        
        _receiverInfoLabel.text = orderModel.express_msg;
    }
    else{
        
        _receiverInfoLabel.text = @"暂无物流信息!";
    }
    //_receiverInfoLabel.text = [NSString stringWithFormat:@"【%@】%@%@%@%@",orderModel.province_name,orderModel.province_name,orderModel.city_name,orderModel.area_name,orderModel.address];
}

#pragma mark - lazyload
- (UIImageView *)logisticsCarImgView{
    
    if (!_logisticsCarImgView) {
        
        _logisticsCarImgView = [UIImageView new];
        _logisticsCarImgView.image = [UIImage imageNamed:@"logisticsCar"];
        _logisticsCarImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _logisticsCarImgView;
}

- (UILabel *)receiverInfoLabel{
    
    if (!_receiverInfoLabel) {
        
        _receiverInfoLabel = [[UILabel alloc] init];
        _receiverInfoLabel.font = KFitFont(14);
        _receiverInfoLabel.textAlignment = NSTextAlignmentLeft;
        _receiverInfoLabel.text = @"上海市松江区";
        _receiverInfoLabel.textColor = KAPP_272727_COLOR;
        _receiverInfoLabel.numberOfLines = 0;
    }
    return _receiverInfoLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [UIImageView new];
        _arrowImgView.image = [UIImage imageNamed:@"order_arrow"];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _arrowImgView;
}

- (UIView *)line{
    
    if (!_line) {
        
        _line = [UIView new];
        _line.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _line;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

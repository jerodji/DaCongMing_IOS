//
//  HYRefundSellerHandleCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/16.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRefundSellerHandleCell.h"

@interface HYRefundSellerHandleCell()

/** 垂直线 */
@property (nonatomic,strong) UIView *verticalLine;
/** 白色背景 */
@property (nonatomic,strong) UIView *whiteBgView;
/** 小点 */
@property (nonatomic,strong) UIImageView *dotImgView;
/** 申请时间 */
@property (nonatomic,strong) UILabel *createTimeLabel;
/** 文字 */
@property (nonatomic,strong) UILabel *createTextLabel;
/** servicePhone */
@property (nonatomic,strong) UILabel *servicePhonelabel;
/** phoneCallBtn */
@property (nonatomic,strong) UIButton *phoneCallBtn;
/** tipsLabel */
@property (nonatomic,strong) UILabel *tipsLabel;

@end

@implementation HYRefundSellerHandleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.verticalLine];
    [self addSubview:self.whiteBgView];
    [self addSubview:self.dotImgView];
    [self addSubview:self.createTimeLabel];
    [self addSubview:self.createTextLabel];
    [self addSubview:self.servicePhonelabel];
    [self addSubview:self.phoneCallBtn];
    [self addSubview:self.tipsLabel];
}

- (void)layoutSubviews{
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(1);
    }];
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(41 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_dotImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_verticalLine);
        make.top.equalTo(_whiteBgView).offset(15 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(11 * WIDTH_MULTIPLE, 11 * WIDTH_MULTIPLE));
    }];
    
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.equalTo(_whiteBgView);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
        make.left.equalTo(_whiteBgView).offset(5);
    }];
    
    [_createTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.height.equalTo(_createTimeLabel);
        make.bottom.equalTo(_whiteBgView);
    }];
    
    CGFloat width = [@"平台服务电话" widthForFont:KFitFont(13)];
    [_servicePhonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.height.equalTo(_createTimeLabel);
        make.width.mas_equalTo(width + 5);
        make.top.equalTo(_whiteBgView.mas_bottom).offset(4 * WIDTH_MULTIPLE);
    }];
    
    CGFloat phoneWidth = [KCustomerServicePhone widthForFont:KFitFont(13)];
    [_phoneCallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.top.equalTo(_servicePhonelabel);
        make.width.mas_equalTo(phoneWidth + 10);
        make.left.equalTo(_servicePhonelabel.mas_right);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.height.equalTo(_servicePhonelabel);
        make.top.equalTo(_servicePhonelabel.mas_bottom);
        make.right.equalTo(self);
    }];
}


#pragma mark - lazyload
- (UIView *)verticalLine{
    
    if (!_verticalLine) {
        
        _verticalLine = [UIView new];
        _verticalLine.backgroundColor = KCOLOR(@"dddddd");
    }
    return _verticalLine;
}

- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
        _whiteBgView.layer.cornerRadius = 6 * WIDTH_MULTIPLE;
        _whiteBgView.layer.masksToBounds = YES;
    }
    return _whiteBgView;
}

- (UIImageView *)dotImgView{
    
    if (!_dotImgView) {
        
        _dotImgView = [UIImageView new];
        _dotImgView.image = [UIImage imageNamed:@"dot"];
    }
    return _dotImgView;
}

- (UILabel *)createTimeLabel{
    
    if (!_createTimeLabel) {
        
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.font = KFitFont(12);
        _createTimeLabel.textAlignment = NSTextAlignmentLeft;
        _createTimeLabel.text = @"2017.10.12";
        _createTimeLabel.textColor = KAPP_272727_COLOR;
    }
    return _createTimeLabel;
}

- (UILabel *)createTextLabel{
    
    if (!_createTextLabel) {
        
        _createTextLabel = [[UILabel alloc] init];
        _createTextLabel.font = KFitFont(14);
        _createTextLabel.textAlignment = NSTextAlignmentLeft;
        _createTextLabel.text = @"申请已提交，商家正在处理中,通常需要1-2个工作日";
        _createTextLabel.textColor = KAPP_272727_COLOR;
    }
    return _createTextLabel;
}

- (UILabel *)servicePhonelabel{
    
    if (!_servicePhonelabel) {
        
        _servicePhonelabel = [[UILabel alloc] init];
        _servicePhonelabel.font = KFitFont(13);
        _servicePhonelabel.textAlignment = NSTextAlignmentLeft;
        _servicePhonelabel.text = @"平台服务电话";
        _servicePhonelabel.textColor = KAPP_272727_COLOR;
    }
    return _servicePhonelabel;
}

- (UIButton *)phoneCallBtn{
    
    if (!_phoneCallBtn) {
        
        _phoneCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneCallBtn setTitle:KCustomerServicePhone forState:UIControlStateNormal];
        [_phoneCallBtn setTitleColor:KAPP_TextSpecial_COLOR forState:UIControlStateNormal];
        _phoneCallBtn.titleLabel.font = KFitFont(13);
        _phoneCallBtn.backgroundColor = KAPP_TableView_BgColor;
    }
    return _phoneCallBtn;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(12);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.text = @"可直接拨打服务电话咨询";
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _tipsLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

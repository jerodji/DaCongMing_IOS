//
//  HYRecommendIntroCell.m
//  DaCongMing
//
//

#import "HYRecommendIntroCell.h"


@interface HYRecommendIntroCell()

@end

@implementation HYRecommendIntroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        [self setupData];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.recommendLabel];
    [self addSubview:self.levelImageView];
    [self addSubview:self.payTimeLabel];
    [self addSubview:self.inviterLabel];
    [self addSubview:self.introLabel];
    [self addSubview:self.introTextLabel];
    [self addSubview:self.line];
//    [self addSubview:self.payMoneyLabel];
}

- (void)setSystemMessageModel:(HYSystemMessageModel *)SystemMessageModel {
    _inviterLabel.text = [NSString stringWithFormat:@"邀请人:%@",SystemMessageModel.recomer_name];
    _introTextLabel.text = SystemMessageModel.msg;
    _recommendLabel.text = [NSString stringWithFormat:@"您已经被邀请成为:%@",SystemMessageModel.recomMsg];
}

- (void)setupData{
    
    _recommendLabel.text = [NSString stringWithFormat:@"您已经被邀请成为:"];
    _recommendLabel.font = [UIFont systemFontOfSize:12];
    _recommendLabel.textColor = UIColorRGB(39, 39, 39);
//    _introTextLabel.text = [HYUserModel sharedInstance].userInfo.userRemind.msg;
    
    [self countDown];
   
}

- (void)countDown{
    
    CGFloat deadlineTime = [[HYUserModel sharedInstance].userInfo.userRemind.close_time floatValue];
    CGFloat currentTimeStamp = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    __block CGFloat timeDiffer = deadlineTime - currentTimeStamp;
    dispatch_queue_t queue = dispatch_queue_create("com.jack.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        //倒计时结束，关闭
        if (timeDiffer <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.time = [NSString stringWithFormat:@"剩余支付时间:%@",[self formatTimeDiffer:timeDiffer]];
                self.payTimeLabel.text = [NSString stringWithFormat:@"剩余支付时间:%@",[self formatTimeDiffer:timeDiffer]];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.time = [NSString stringWithFormat:@"剩余支付时间:%@",[self formatTimeDiffer:timeDiffer]];
                self.payTimeLabel.text = [NSString stringWithFormat:@"剩余支付时间:%@",[self formatTimeDiffer:timeDiffer]];
                timeDiffer--;
            });
        }
        
        
    });
    dispatch_resume(timer);
}

- (NSString *)formatTimeDiffer:(CGFloat)timerDiffer{
    
    NSString *result = @"";
    if (timerDiffer > 60 * 60 * 24) {
        
        NSInteger days = timerDiffer / (60 * 60 * 24);
        NSInteger hours = (int)timerDiffer % (60 * 60 * 24) / 3600;
        result = [NSString stringWithFormat:@"%ld天%ld小时",(long)days,(long)hours];
    }
    else if (timerDiffer > 60 * 60) {
        
        NSInteger hours = (int)timerDiffer / (60 * 60);
        result = [NSString stringWithFormat:@"%ld小时",(long)hours];
    }
    else if (timerDiffer > 60){
        
        NSInteger minutes = (int)timerDiffer / 60;
        result = [NSString stringWithFormat:@"%ld小时",(long)minutes];
    }
    else if (timerDiffer <= 0){
        
        result = @"时间到了";
    }
    return result;
}

- (void)layoutSubviews{
    
    [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(25);
    }];
    
    [_levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(188);
        make.height.mas_equalTo(75);
        make.top.equalTo(_recommendLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self);
    }];
    
    [_payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);//.offset(15 * WIDTH_MULTIPLE);
        //make.top.equalTo(_recommendLabel.mas_bottom).offset(15 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    [_inviterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.top.equalTo(_levelImageView.mas_bottom).offset(30 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(15 * WIDTH_MULTIPLE);
    }];
    
    CGFloat height = [@"" heightForFont:KFitFont(13) width:30];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_inviterLabel.mas_bottom).offset(13);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_introTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_introLabel.mas_right);
        make.top.equalTo(_introLabel);
        make.right.equalTo(self).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(60);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.size.width-40);
        make.height.mas_equalTo(1);
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(_payTimeLabel.mas_top).offset(-10);
    }];
    
    [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.bottom.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
        make.left.equalTo(self);
    }];
}

#pragma mark - setter
- (void)setPayAmount:(NSString *)payAmount{
    
    _payAmount = payAmount;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"加盟费:￥%@",self.payAmount]];
    [attributeStr addAttributes:@{NSFontAttributeName : KFitFont(13),NSForegroundColorAttributeName : KAPP_272727_COLOR} range:NSMakeRange(0, attributeStr.length)];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_PRICE_COLOR} range:NSMakeRange(4, attributeStr.length - 4)];
    _payMoneyLabel.attributedText = attributeStr;
}

/** V0没有权限 V2实习经销商 V3高级经销商 V4实习合伙人 V5高级合伙人 V6特约合伙人 */
- (void)setUnit:(NSString *)unit {
    _unit = unit;
    if ([_unit isEqualToString:@"V0"]) {
        
    } else if ([_unit isEqualToString:@"V2"]) {
        _levelImageView.image = [UIImage imageNamed:@"sxjxs"];
    }
    else if ([_unit isEqualToString:@"V3"]) {
        _levelImageView.image = [UIImage imageNamed:@"gjjss"];
    }
    else if ([_unit isEqualToString:@"V4"]) {
        _levelImageView.image = [UIImage imageNamed:@"sxhhr"];
    }
    else if ([_unit isEqualToString:@"V5"]) {
        _levelImageView.image = [UIImage imageNamed:@"gjhhr"];
    }
    else if ([_unit isEqualToString:@"V6"]) {
        _levelImageView.image = [UIImage imageNamed:@""];
    } else {
        
    }
}

#pragma mark - lazyload
- (UILabel *)recommendLabel{
    
    if (!_recommendLabel) {
        
        _recommendLabel = [[UILabel alloc] init];
        _recommendLabel.font = KFitBoldFont(19);
        _recommendLabel.textColor = KCOLOR(@"272727");
        _recommendLabel.text = @"您已经被推荐为:";
        _recommendLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _recommendLabel;
}

- (UILabel *)payTimeLabel{
    
    if (!_payTimeLabel) {
        
        _payTimeLabel = [[UILabel alloc] init];
        _payTimeLabel.font = KFitFont(13);
        _payTimeLabel.textColor = KAPP_272727_COLOR;
        _payTimeLabel.text = @"剩余支付时间:2天";
        _payTimeLabel.textAlignment = NSTextAlignmentCenter;
        _time = @"剩余支付时间:2天";
    }
    return _payTimeLabel;
}

- (UILabel *)inviterLabel{
    
    if (!_inviterLabel) {
        
        _inviterLabel = [[UILabel alloc] init];
        _inviterLabel.font = KFitFont(13);
        _inviterLabel.textColor = KAPP_b7b7b7_COLOR;
        _inviterLabel.text = @"邀请人:";
        _inviterLabel.textAlignment = NSTextAlignmentLeft;
//        _inviterLabel.backgroundColor = [UIColor redColor];
    }
    return _inviterLabel;
}

- (UILabel *)introLabel{
    
    if (!_introLabel) {
        
        _introLabel = [[UILabel alloc] init];
        _introLabel.font = KFitFont(13);
        _introLabel.textColor = KAPP_b7b7b7_COLOR;
        _introLabel.text = @"说明:";
        _introLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _introLabel;
}

- (HYLabel *)introTextLabel{
    
    if (!_introTextLabel) {
        
        _introTextLabel = [[HYLabel alloc] init];
        _introTextLabel.font = KFitFont(13);
        _introTextLabel.textColor = KAPP_b7b7b7_COLOR;
        _introTextLabel.text = @"发的发生温热地方的发生如风达方式范德萨发的防守打法都是仿发生的发生佛挡杀佛的范德萨发";
        _introTextLabel.textAlignment = NSTextAlignmentLeft;
        _introTextLabel.verticalAlignment = VerticalAlignmentTop;
        _introTextLabel.numberOfLines = 0;
//        _introTextLabel.backgroundColor = [UIColor grayColor];
    }
    return _introTextLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIColorRGB(229, 229, 229);
    }
    return _line;
}

- (UILabel *)payMoneyLabel{
    
    if (!_payMoneyLabel) {
        
        _payMoneyLabel = [[UILabel alloc] init];
        _payMoneyLabel.font = KFitFont(13);
        _payMoneyLabel.textColor = KAPP_272727_COLOR;
        _payMoneyLabel.text = @"加盟费:￥99999.9999";
        _payMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _payMoneyLabel;
}

- (UIImageView *)levelImageView {
    if (!_levelImageView) {
        _levelImageView = [[UIImageView alloc] init];
//        _levelImageView.backgroundColor = [UIColor redColor];
    }
    return _levelImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

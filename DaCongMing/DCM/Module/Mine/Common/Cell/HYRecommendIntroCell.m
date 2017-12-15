//
//  HYRecommendIntroCell.m
//  DaCongMing
//
//  Created by Jack on 2017/12/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendIntroCell.h"
#import "HYLabel.h"

@interface HYRecommendIntroCell()

/** 推荐 */
@property (nonatomic,strong) UILabel *recommendLabel;
/** 剩余支付时间 */
@property (nonatomic,strong) UILabel *payTimeLabel;
/** 邀请人 */
@property (nonatomic,strong) UILabel *inviterLabel;
/** 介绍 */
@property (nonatomic,strong) UILabel *introLabel;
/** 介绍文本 */
@property (nonatomic,strong) HYLabel *introTextLabel;
/** 加盟费 */
@property (nonatomic,strong) UILabel *payMoneyLabel;

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
    [self addSubview:self.payTimeLabel];
    [self addSubview:self.inviterLabel];
    [self addSubview:self.introLabel];
    [self addSubview:self.introTextLabel];
    [self addSubview:self.payMoneyLabel];
}

- (void)setupData{
    
    _recommendLabel.text = [NSString stringWithFormat:@"你已经被推荐为:%@",[HYUserModel sharedInstance].userInfo.userRemind.recomMsg];
    _inviterLabel.text = [NSString stringWithFormat:@"邀请人:%@",[HYUserModel sharedInstance].userInfo.userRemind.recomer_name];
    _introTextLabel.text = [HYUserModel sharedInstance].userInfo.userRemind.msg;
    
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
                
                self.payTimeLabel.text = [NSString stringWithFormat:@"剩余支付时间:%@",[self formatTimeDiffer:timeDiffer]];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
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
       
        make.left.top.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(25 * WIDTH_MULTIPLE);
    }];
    
    [_payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.top.equalTo(_recommendLabel.mas_bottom).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    [_inviterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.top.equalTo(_payTimeLabel.mas_bottom).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
    }];
    
    CGFloat height = [@"" heightForFont:KFitFont(13) width:30];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_inviterLabel.mas_bottom).offset(15 * WIDTH_MULTIPLE);
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_introTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_introLabel.mas_right);
        make.top.equalTo(_introLabel);
        make.right.equalTo(self).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50);
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

#pragma mark - lazyload
- (UILabel *)recommendLabel{
    
    if (!_recommendLabel) {
        
        _recommendLabel = [[UILabel alloc] init];
        _recommendLabel.font = KFitBoldFont(19);
        _recommendLabel.textColor = KCOLOR(@"272727");
        _recommendLabel.text = @"您已经被推荐为:高级经销商";
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
        _payTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _payTimeLabel;
}

- (UILabel *)inviterLabel{
    
    if (!_inviterLabel) {
        
        _inviterLabel = [[UILabel alloc] init];
        _inviterLabel.font = KFitFont(13);
        _inviterLabel.textColor = KAPP_b7b7b7_COLOR;
        _inviterLabel.text = @"邀请人:好几款";
        _inviterLabel.textAlignment = NSTextAlignmentLeft;
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
    }
    return _introTextLabel;
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

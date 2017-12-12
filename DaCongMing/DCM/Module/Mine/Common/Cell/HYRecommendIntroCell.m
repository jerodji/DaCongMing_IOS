//
//  HYRecommendIntroCell.m
//  DaCongMing
//
//  Created by Jack on 2017/12/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYRecommendIntroCell.h"

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
@property (nonatomic,strong) UILabel *introTextLabel;
/** 加盟费 */
@property (nonatomic,strong) UILabel *payMoneyLabel;

@end

@implementation HYRecommendIntroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
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
    
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(40 * WIDTH_MULTIPLE);
    }];
    
    [_introTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_introLabel.mas_right);
        make.right.equalTo(_introLabel);
        make.right.equalTo(self).offset(-20 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(50);
    }];
    
    [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.bottom.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20 * WIDTH_MULTIPLE);
        make.left.equalTo(self);
    }];
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

- (UILabel *)introTextLabel{
    
    if (!_introTextLabel) {
        
        _introTextLabel = [[UILabel alloc] init];
        _introTextLabel.font = KFitFont(13);
        _introTextLabel.textColor = KAPP_b7b7b7_COLOR;
        _introTextLabel.text = @"发的发生温热地方的发生如风达方式范德萨发的防守打法都是仿发生的发生佛挡杀佛的范德萨发";
        _introTextLabel.textAlignment = NSTextAlignmentLeft;
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

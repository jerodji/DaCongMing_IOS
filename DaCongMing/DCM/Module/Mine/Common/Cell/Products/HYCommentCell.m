//
//  HYCommentCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCommentCell.h"
#import "StarRatingView.h"


@interface HYCommentCell()

/** 图像 */
@property (nonatomic,strong) UIImageView *headerImgView;
/** nickNameLabel */
@property (nonatomic,strong) UILabel *nickNameLabel;
/** 内容 */
@property (nonatomic,strong) UILabel *contentLabel;
/** 好 */
@property (nonatomic,strong) UILabel *stateLabel;
/** 评分 */
@property (nonatomic,strong) StarRatingView *starView;
/** 时间 */
@property (nonatomic,strong) UILabel *timeLabel;
/** 底部黑线 */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        self.backgroundColor = KAPP_WHITE_COLOR;
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.headerImgView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.starView];
    [self addSubview:self.stateLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.bottomLine];
    
}

- (void)layoutSubviews{
    
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(50 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE));
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headerImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_headerImgView).offset(4 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(160 * WIDTH_MULTIPLE);
    }];
    
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_nickNameLabel);
        make.top.equalTo(_nickNameLabel.mas_bottom);
        make.width.mas_equalTo(160 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_starView.mas_right);
        make.height.top.equalTo(_starView);
        make.width.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(_nickNameLabel);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(100 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_headerImgView);
        make.top.equalTo(_headerImgView.mas_bottom).offset(15 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 *WIDTH_MULTIPLE);
    }];
    
}

#pragma mark - setter
- (void)setCommentModel:(HYCommentModel *)commentModel{
    
    _commentModel = commentModel;
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:commentModel.head_image_url] placeholderImage:[UIImage imageNamed:@"shopIconPlaceholder"]];
    _nickNameLabel.text = commentModel.user_name;
    _contentLabel.text = commentModel.evaluate_msg;
    _starView.score = [commentModel.evaluate_level floatValue];
    _timeLabel.text = commentModel.create_time;
    NSString *text = commentModel.evaluate_msg;
    CGFloat textHeight = [text heightForFont:KFitFont(14) width:(KSCREEN_WIDTH - 20 * WIDTH_MULTIPLE)];
    [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(textHeight);
    }];
    NSString *state = [commentModel.evaluate_level integerValue] == 5 ? @"非常好" : [commentModel.evaluate_level integerValue] == 4 ? @"好" :[commentModel.evaluate_level integerValue] == 3 ? @"一般":[commentModel.evaluate_level integerValue] == 2 ? @"差":[commentModel.evaluate_level integerValue] == 1 ? @"很差" : @"一般";
    self.stateLabel.text = state;
    [self layoutIfNeeded];
    commentModel.cellHeight = _contentLabel.bottom + 20 * WIDTH_MULTIPLE;
}

#pragma mark - lazyload
- (UIImageView *)headerImgView{
    
    if (!_headerImgView) {
        
        _headerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopIconPlaceholder"]];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImgView.clipsToBounds = YES;
        _headerImgView.layer.cornerRadius = 25 * WIDTH_MULTIPLE;
    }
    return _headerImgView;
}

- (UILabel *)nickNameLabel{
    
    if (!_nickNameLabel) {
        
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = KFitFont(14);
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.text = @"风车大战骑士";
        _nickNameLabel.textColor = KAPP_272727_COLOR;
        
    }
    return _nickNameLabel;
}

- (UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = KFitFont(14);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.text = @"效果特别好，效果特别好，效果特别好，效果特别好，效果特别好，效果特别好";
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = KAPP_272727_COLOR;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = KFitFont(12);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"2017.12.12";
        _timeLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _timeLabel;
}

- (UILabel *)stateLabel{
    
    if (!_stateLabel) {
        
        _stateLabel = [UILabel new];
        _stateLabel.text = @"好";
        _stateLabel.textColor = KAPP_272727_COLOR;
        _stateLabel.font = KFitFont(14);
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _stateLabel;
}

- (StarRatingView *)starView{
    
    if (!_starView) {
        
        _starView = [[StarRatingView alloc] initWithFrame:CGRectMake(0, 0, 20, 30 * WIDTH_MULTIPLE) rateStyle:RateStyleOptional];
    }
    return _starView;
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

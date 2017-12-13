//
//  HYSystemMessageCell.m
//  DaCongMing
//
//  Created by Jack on 2017/12/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSystemMessageCell.h"

@interface HYSystemMessageCell()

@property (nonatomic,strong) UIView *whiteBgView;
/** 日期 */
@property (nonatomic,strong) UILabel *dateLabel;
/** 标题 */
@property (nonatomic,strong) UILabel *titleLabel;
/** 文本 */
@property (nonatomic,strong) UILabel *detailLabel;
/** 标记 */
@property (nonatomic,strong) UIView *markView;
/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;

@end

@implementation HYSystemMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KAPP_TableView_BgColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.whiteBgView];
    [self addSubview:self.dateLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.markView];
    [self addSubview:self.arrowImgView];
}

- (void)layoutSubviews{
    
    [_whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self).offset(15 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-15 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_whiteBgView);
        make.left.right.equalTo(_whiteBgView);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteBgView).offset(21 * WIDTH_MULTIPLE);
        make.top.equalTo(_whiteBgView).offset(30 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
        make.right.equalTo(_whiteBgView);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.height.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(self);
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteBgView).offset(7 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(8 * WIDTH_MULTIPLE, 8 * WIDTH_MULTIPLE));
        make.centerY.equalTo(_detailLabel);
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_whiteBgView).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(_whiteBgView);
    }];
}

#pragma mark - lazyload
- (UIView *)whiteBgView{
    
    if (!_whiteBgView) {
        
        _whiteBgView = [UIView new];
        _whiteBgView.backgroundColor = KAPP_WHITE_COLOR;
        _whiteBgView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _whiteBgView.clipsToBounds = YES;
    }
    return _whiteBgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        _titleLabel.text = @"马上加入大聪明";
        _titleLabel.textColor = KAPP_272727_COLOR;
        _titleLabel.font = KFitBoldFont(18);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIView *)markView{
    
    if (!_markView) {
        
        _markView = [UILabel new];
        _markView.backgroundColor = KAPP_THEME_COLOR;
        _markView.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
        _markView.clipsToBounds = YES;
    }
    return _markView;
}

- (UILabel *)detailLabel{
    
    if (!_detailLabel) {
        
        _detailLabel = [UILabel new];
        _detailLabel.text = @"用户好莱坞邀请你成为高级代理";
        _detailLabel.textColor = KAPP_272727_COLOR;
        _detailLabel.font = KFitFont(13);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}

- (UILabel *)dateLabel{
    
    if (!_dateLabel) {
        
        _dateLabel = [UILabel new];
        _dateLabel.text = @"12月21号";
        _dateLabel.textColor = KAPP_b7b7b7_COLOR;
        _dateLabel.font = KFitFont(13);
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
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

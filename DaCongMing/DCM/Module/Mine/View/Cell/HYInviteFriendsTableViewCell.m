//
//  HYInviteFriendsTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYInviteFriendsTableViewCell.h"

@interface HYInviteFriendsTableViewCell()

/** redViwe */
@property (nonatomic,strong) UIView *redView;
/** icon */
@property (nonatomic,strong) UIImageView *iconImgView;
/** title */
@property (nonatomic,strong) UILabel *titleLabel;
/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;

@end

@implementation HYInviteFriendsTableViewCell

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

    [self addSubview:self.redView];
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowImgView];
}

- (void)layoutSubviews{
    
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self.redView).offset(10);
        make.bottom.equalTo(self.redView).offset(-10);
        make.width.equalTo(@30);
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self.iconImgView);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@30);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self.iconImgView);
        make.left.equalTo(self.iconImgView.mas_right).offset(7 * WIDTH_MULTIPLE);
        make.right.equalTo(self.arrowImgView.mas_left);
    }];
}

#pragma mark - lazyload
- (UIView *)redView{
    
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = KCOLOR(@"bd2b2c");
    }
    return _redView;
}

- (UIImageView *)iconImgView{
    
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_horn"]];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImgView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(14);
        _titleLabel.textColor = KAPP_WHITE_COLOR;
        _titleLabel.text = @"邀请好友，获取现金红包券";
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

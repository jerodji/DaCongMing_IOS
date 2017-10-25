//
//  HYConfirmSuccessCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYConfirmSuccessCell.h"

@interface HYConfirmSuccessCell()

/** 收获成功 */
@property (nonatomic,strong) UIImageView *successImgView;
/** 查看订单 */
@property (nonatomic,strong) UIButton *lookOrderBtn;
/** 去评价 */
@property (nonatomic,strong) UIButton *commentBtn;
/** 底部黑线 */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYConfirmSuccessCell

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
    
    [self addSubview:self.successImgView];
    [self addSubview:self.lookOrderBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    [_lookOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self).offset(-30 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(130 * WIDTH_MULTIPLE, 35 * WIDTH_MULTIPLE));
        make.right.mas_equalTo(self.mas_left).offset(self.width / 2 - 10 * WIDTH_MULTIPLE);
    }];
    
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.top.equalTo(_lookOrderBtn);
        make.left.mas_equalTo(self).offset(self.width / 2 + 10 * WIDTH_MULTIPLE);
    }];
    
    [_successImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self);
        make.bottom.mas_equalTo(_lookOrderBtn.mas_top).offset(-28 * WIDTH_MULTIPLE);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - action
- (void)lookOrderAction{
    
    if (self.lookOrderBlock) {
        
        self.lookOrderBlock();
    }
}

- (void)commentBtnAction{
    
    if (self.commentBlock) {
        
        self.commentBlock();
    }
}

#pragma mark - lazyload
- (UIImageView *)successImgView{
    
    if (!_successImgView) {
        
        _successImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"confirmReceive"]];
        _successImgView.contentMode = UIViewContentModeScaleAspectFill;
        _successImgView.clipsToBounds = YES;
    }
    return _successImgView;
}

- (UIButton *)lookOrderBtn{
    
    if (!_lookOrderBtn) {
        
        _lookOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        _lookOrderBtn.backgroundColor = KAPP_WHITE_COLOR;
        [_lookOrderBtn setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _lookOrderBtn.titleLabel.font = KFitFont(14);
        _lookOrderBtn.layer.cornerRadius = 2 * WIDTH_MULTIPLE;
        _lookOrderBtn.layer.borderColor = KAPP_b7b7b7_COLOR.CGColor;
        _lookOrderBtn.layer.borderWidth = 1;
        _lookOrderBtn.clipsToBounds = YES;
        [_lookOrderBtn addTarget:self action:@selector(lookOrderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookOrderBtn;
}

- (UIButton *)commentBtn{
    
    if (!_commentBtn) {
        
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitle:@"去评价" forState:UIControlStateNormal];
        _commentBtn.backgroundColor = KAPP_THEME_COLOR;
        [_commentBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = KFitFont(14);
        _commentBtn.layer.cornerRadius = 2 * WIDTH_MULTIPLE;
        _commentBtn.layer.borderColor = KAPP_b7b7b7_COLOR.CGColor;
        _commentBtn.layer.borderWidth = 1;
        _commentBtn.clipsToBounds = YES;
        [_commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

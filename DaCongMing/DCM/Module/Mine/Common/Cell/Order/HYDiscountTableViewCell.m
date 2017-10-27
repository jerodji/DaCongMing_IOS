//
//  HYDiscountTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYDiscountTableViewCell.h"

@interface HYDiscountTableViewCell()

/** 优惠券 */
@property (nonatomic,strong) UILabel *discountLabel;
/** 选择优惠券 */
@property (nonatomic,strong) UILabel *discountSelectLabel;
/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;
/** 张数 */
@property (nonatomic,strong) UILabel *discountCoponCountLabel;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

@end

@implementation HYDiscountTableViewCell

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
    
    [self addSubview:self.discountLabel];
    [self addSubview:self.discountCoponCountLabel];
    [self addSubview:self.discountSelectLabel];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.bottomLine];
}

- (void)layoutSubviews{
    
    CGFloat discountLabelWidth = [@"优惠券:" widthForFont:KFitFont(15)];
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.centerY.equalTo(self);
        make.height.equalTo(@20);
        make.width.equalTo(@(discountLabelWidth + 10));
    }];
    
    [_discountSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_discountLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.height.equalTo(@20);
        make.width.equalTo(@(100));
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(20 / 1.77));
        make.centerY.equalTo(self);
        make.height.equalTo(@(20));
    }];
    
    [_discountCoponCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_arrowImgView.mas_left).offset(-5);
        make.top.bottom.equalTo(_discountLabel);
        make.width.equalTo(@100);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

#pragma mark - lazyload
- (UILabel *)discountLabel{
    
    if (!_discountLabel) {
        
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.font = KFitFont(15);
        _discountLabel.textAlignment = NSTextAlignmentLeft;
        _discountLabel.text = @"优惠券:";
        _discountLabel.textColor = KAPP_272727_COLOR;
    }
    return _discountLabel;
}

- (UILabel *)discountSelectLabel{
    
    if (!_discountSelectLabel) {
        
        _discountSelectLabel = [[UILabel alloc] init];
        _discountSelectLabel.font = KFitFont(15);
        _discountSelectLabel.textAlignment = NSTextAlignmentLeft;
        _discountSelectLabel.text = @"未选择";
        _discountSelectLabel.textColor = KAPP_484848_COLOR;
    }
    return _discountSelectLabel;
}

- (UILabel *)discountCoponCountLabel{
    
    if (!_discountCoponCountLabel) {
        
        _discountCoponCountLabel = [[UILabel alloc] init];
        _discountCoponCountLabel.font = KFitFont(15);
        _discountCoponCountLabel.textAlignment = NSTextAlignmentRight;
        _discountCoponCountLabel.text = @"0张";
        _discountCoponCountLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _discountCoponCountLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
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

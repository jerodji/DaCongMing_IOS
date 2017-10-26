//
//  HYCommentTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/25.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCommentTableViewCell.h"
#import "StarRatingView.h"

@interface HYCommentTableViewCell() <UITextViewDelegate,HYStarRatingDelegate>

/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** 商品图片 */
@property (nonatomic,strong) UIImageView *itemImgView;
/** itemNameLabel */
@property (nonatomic,strong) UILabel *itemLabel;
/** 规格 */
@property (nonatomic,strong) UILabel *unitLabel;
/** 价格 */
@property (nonatomic,strong) UILabel *priceLabel;
/** 数量 */
@property (nonatomic,strong) UILabel *countLabel;
/** middleLine */
@property (nonatomic,strong) UIView *middleLine;
/** 评分Label */
@property (nonatomic,strong) UILabel *gradeLabel;
/** 底部黑线 */
@property (nonatomic,strong) UIView *bottomLine;

@property (nonatomic,strong) SAMTextView *commentTextView;
/** starRatingView */
@property (nonatomic,strong) StarRatingView *starRatingView;
/** 评分状态Label */
@property (nonatomic,strong) UILabel *stateLabel;
/** 分数 */
@property (nonatomic,assign) CGFloat score;

@end

@implementation HYCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        self.backgroundColor = KCOLOR(@"f6f6f6");
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.itemImgView];
    [self addSubview:self.itemLabel];
    [self addSubview:self.unitLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.bottomLine];
    [self addSubview:self.middleLine];
    [self addSubview:self.gradeLabel];
    [self addSubview:self.starRatingView];
    [self addSubview:self.commentTextView];
    [self addSubview:self.stateLabel];
}

- (void)layoutSubviews{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10 * WIDTH_MULTIPLE);

    }];
    
    [_itemImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_bgView).offset(10 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(70 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(80 * WIDTH_MULTIPLE);
    }];
    
    [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_itemImgView.mas_right).offset(10 * WIDTH_MULTIPLE);
        make.top.equalTo(_itemImgView);
        make.height.mas_equalTo(20);
        make.right.equalTo(self);
    }];
    
    [_unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_itemLabel.mas_bottom).offset(2 * WIDTH_MULTIPLE);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(250);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(_itemLabel);
        make.width.mas_equalTo(100);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(_itemImgView);
        make.left.equalTo(_itemLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.bottom.equalTo(_bgView);
        make.height.mas_equalTo(1);
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self);
        make.top.equalTo(_itemImgView.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(1);
    }];
    
    CGFloat width = [@"对商品评分:" widthForFont:KFitFont(14)];
    [_gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_itemImgView);
        make.top.equalTo(_middleLine.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(40 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(width + 10);
    }];
    
    [_starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_gradeLabel.mas_right);
        make.height.top.equalTo(_gradeLabel);
        make.width.mas_equalTo(160 * WIDTH_MULTIPLE);
    }];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_starRatingView.mas_right);
        make.height.top.equalTo(_gradeLabel);
        make.width.mas_equalTo(60 * WIDTH_MULTIPLE);
    }];
    
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_itemImgView);
        make.top.equalTo(_gradeLabel.mas_bottom).offset(10 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(80 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
    }];
    
}

#pragma mark - setter
- (void)setOrderDetailModel:(HYMyOrderDetailsModel *)orderDetailModel{
    
    _orderDetailModel = orderDetailModel;
    [_itemImgView sd_setImageWithURL:[NSURL URLWithString:orderDetailModel.item_title_image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _itemLabel.text = orderDetailModel.item_name;
    _unitLabel.text = orderDetailModel.unit;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",orderDetailModel.price];
    _countLabel.text = [NSString stringWithFormat:@"x%@",orderDetailModel.qty];
    
}

#pragma mark - 评分delegate
- (void)starRatingWithScore:(CGFloat)score{
    
    DLog(@"score is %f",score);
    NSString *state = (int)score == 5 ? @"非常好" : (int)score == 4 ? @"好" :(int)score == 3 ? @"一般":(int)score == 2 ? @"差":(int)score == 4 ? @"很差":@"一般";
    self.stateLabel.text = state;
    self.score = score;
    if (_delegate && [_delegate respondsToSelector:@selector(commentWithText:andScore:WithIndexPath:)]) {
        
        [_delegate commentWithText:self.commentTextView.text andScore:score WithIndexPath:self.indexPath];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (_delegate && [_delegate respondsToSelector:@selector(commentWithText:andScore:WithIndexPath:)]) {
        
        [_delegate commentWithText:self.commentTextView.text andScore:self.score WithIndexPath:self.indexPath];
    }
}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UIImageView *)itemImgView{
    
    if (!_itemImgView) {
        
        _itemImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _itemImgView.contentMode = UIViewContentModeScaleAspectFill;
        _itemImgView.clipsToBounds = YES;
        _itemImgView.image = [UIImage imageNamed:@"productPlaceholder"];
    }
    
    return _itemImgView;
}

- (UILabel *)itemLabel{
    
    if (!_itemLabel) {
        
        _itemLabel = [UILabel new];
        _itemLabel.text = @"来自老挝的天然健康产品";
        _itemLabel.textColor = KAPP_272727_COLOR;
        _itemLabel.font = KFitFont(14);
        _itemLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _itemLabel;
}

- (UILabel *)unitLabel{
    
    if (!_unitLabel) {
        
        _unitLabel = [UILabel new];
        _unitLabel.text = @"100g";
        _unitLabel.textColor = KAPP_b7b7b7_COLOR;
        _unitLabel.font = KFitFont(12);
        _unitLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _unitLabel;
}

- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [UILabel new];
        _priceLabel.text = @"$10";
        _priceLabel.textColor = KAPP_PRICE_COLOR;
        _priceLabel.font = KFitFont(14);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _priceLabel;
}

- (UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [UILabel new];
        _countLabel.text = @"x1";
        _countLabel.textColor = KAPP_272727_COLOR;
        _countLabel.font = KFitFont(14);
        _countLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _countLabel;
}

- (UILabel *)gradeLabel{
    
    if (!_gradeLabel) {
        
        _gradeLabel = [UILabel new];
        _gradeLabel.text = @"对商品评分:";
        _gradeLabel.textColor = KAPP_272727_COLOR;
        _gradeLabel.font = KFitFont(14);
        _gradeLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _gradeLabel;
}

- (UILabel *)stateLabel{
    
    if (!_stateLabel) {
        
        _stateLabel = [UILabel new];
        _stateLabel.text = @"好";
        _stateLabel.textColor = KAPP_b7b7b7_COLOR;
        _stateLabel.font = KFitFont(14);
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _stateLabel;
}

- (StarRatingView *)starRatingView{
    
    if (!_starRatingView) {
        
        _starRatingView = [[StarRatingView alloc] initWithFrame:CGRectMake(0, 0, 20, 40 * WIDTH_MULTIPLE) rateStyle:RateStyleOptional];
        _starRatingView.delegate = self;
    }
    return _starRatingView;
}

- (UIView *)bottomLine{
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
        
        _middleLine = [UIView new];
        _middleLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _bottomLine;
}

- (SAMTextView *)commentTextView{
    
    if (!_commentTextView) {
        
        _commentTextView = [[SAMTextView alloc] init];
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@" 请输入对商品的评价" attributes:@{NSForegroundColorAttributeName : KAPP_b7b7b7_COLOR,NSFontAttributeName : KFitFont(16)}];
        _commentTextView.attributedPlaceholder = attributeStr;
        _commentTextView.font = KFitFont(16);
        _commentTextView.textColor = KAPP_272727_COLOR;
        _commentTextView.delegate = self;
        _commentTextView.backgroundColor = KCOLOR(@"f6f6f6");
        _commentTextView.layer.cornerRadius = 5;
        _commentTextView.layer.borderColor = KCOLOR(@"e9e9e9").CGColor;
        _commentTextView.layer.borderWidth = 1;
    }
    return _commentTextView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

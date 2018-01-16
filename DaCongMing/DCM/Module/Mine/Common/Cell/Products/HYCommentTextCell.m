//
//  HYCommentTextCell.m
//  DaCongMing
//
//

#import "HYCommentTextCell.h"

@interface HYCommentTextCell()

/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** 数量 */
@property (nonatomic,strong) UILabel *countLabel;
/** 底部黑线 */
@property (nonatomic,strong) UIView *bottomLine;

@end


@implementation HYCommentTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        self.backgroundColor = KAPP_TableView_BgColor;
    }
    return self;
}

- (void)setupSubviews{
    
    [self addSubview:self.bgView];
    [self addSubview:self.countLabel];
    [self addSubview:self.bottomLine];
    
    [self layoutIfNeeded];
    [_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self);
//        if (self.size.height > 0) {
//            
//            make.top.equalTo(self).offset(8 * WIDTH_MULTIPLE);
//            make.left.right.bottom.equalTo(self);
//        }
//        else{
//            make.left.right.top.bottom.equalTo(self);
//        }
    }];
}

- (void)layoutSubviews{
    
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.top.bottom.width.equalTo(_bgView);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setter
- (void)setCount:(NSString *)count{
    
    _count = count;
    _countLabel.text = [NSString stringWithFormat:@"晒单评价(%@)",count];

}

#pragma mark - lazyload
- (UIView *)bgView{
    
    if (!_bgView) {
        
        _bgView = [UIView new];
        _bgView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _bgView;
}

- (UILabel *)countLabel{
    
    if (!_countLabel) {
        
        _countLabel = [UILabel new];
        _countLabel.text = @"晒单评价(10)";
        _countLabel.textColor = KAPP_272727_COLOR;
        _countLabel.font = KFitFont(18);
        _countLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _countLabel;
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

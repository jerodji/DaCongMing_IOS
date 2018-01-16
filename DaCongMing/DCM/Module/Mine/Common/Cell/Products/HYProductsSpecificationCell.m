//
//  HYProductsSpecificationCell.m
//  DaCongMing
//
//

#import "HYProductsSpecificationCell.h"

@interface HYProductsSpecificationCell()

/** titlelabel */
@property (nonatomic,strong) UILabel *titleLabel;
/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;

/** topLine */
@property (nonatomic,strong) UIView *topLine;
/** bottomLine */
@property (nonatomic,strong) UIView *bottomLine;

@end


@implementation HYProductsSpecificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.arrowImgView];
        [self addSubview:self.topLine];
        [self addSubview:self.bottomLine];
    }
    return self;
}

- (void)layoutSubviews{
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
        make.right.equalTo(_arrowImgView.mas_left);
        make.height.top.equalTo(self);
    }];
    
    [_arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(20 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self).offset(-20 * WIDTH_MULTIPLE);
        make.right.equalTo(self).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@30);
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

#pragma mark - lazyload
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFitFont(15);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"请选择规格及数量";
        _titleLabel.textColor = KCOLOR(@"7b7b7b");
    }
    return _titleLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
}

- (UIView *)topLine{
    
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = KAPP_SEPERATOR_COLOR;
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KAPP_SEPERATOR_COLOR;
    }
    return _topLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

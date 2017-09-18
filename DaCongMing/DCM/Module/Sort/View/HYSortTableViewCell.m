//
//  HYSortTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYSortTableViewCell.h"

@interface HYSortTableViewCell()

/** img */
@property (nonatomic,strong) UIImageView *imgView;

@end


@implementation HYSortTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{

    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(5 * WIDTH_MULTIPLE);
    }];
}

- (void)setModel:(HYSortModel *)model{
    
    _model = model;
     [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.img_url] placeholderImage:[UIImage imageNamed:@"placeHolderImg"]];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.img_url] placeholderImage:[UIImage imageNamed:@"placeHolderImg"]];
    }
    
    return _imgView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

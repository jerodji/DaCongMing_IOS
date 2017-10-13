//
//  HYOrderDetailImageCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/13.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYOrderDetailImageCell.h"

@interface HYOrderDetailImageCell()

/** 物流图 */
@property (nonatomic,strong) UIImageView *logisticsImgView;

@end

@implementation HYOrderDetailImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.logisticsImgView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [_logisticsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.equalTo(self);
    }];
}

#pragma mark - lazyload
- (UIImageView *)logisticsImgView{
    
    if (!_logisticsImgView) {
        
        _logisticsImgView = [UIImageView new];
        _logisticsImgView.image = [UIImage imageNamed:@"logisticsImage"];
        _logisticsImgView.contentMode = UIViewContentModeScaleAspectFill;
        _logisticsImgView.clipsToBounds = YES;
    }
    return _logisticsImgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

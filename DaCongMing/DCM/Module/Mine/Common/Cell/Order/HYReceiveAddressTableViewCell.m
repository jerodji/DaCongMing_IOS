//
//  HYReceiveAddressTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYReceiveAddressTableViewCell.h"

@interface HYReceiveAddressTableViewCell()

/** 条 */
@property (nonatomic,strong) UIImageView *stripImgView;
/** 收货地址 */
@property (nonatomic,strong) UILabel *addressLabel;
/** arrow */
@property (nonatomic,strong) UIImageView *arrowImgView;

@end

@implementation HYReceiveAddressTableViewCell

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
    
    
}

#pragma mark - lazyload
- (UIImageView *)stripImgView{
    
    if (!_stripImgView) {
        
        _stripImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_strip"]];
        _stripImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stripImgView;
}

- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = KFitFont(15);
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.text = @"暂无收货地址，点击添加新收货地址";
        _addressLabel.textColor = KCOLOR(@"7b7b7b");
    }
    return _addressLabel;
}

- (UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_arrow"]];
        _arrowImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

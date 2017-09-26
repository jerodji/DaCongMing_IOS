//
//  HYMineInfoTableViewCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/19.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMineInfoTableViewCell.h"

@interface HYMineInfoTableViewCell()

/** imgArray */
@property (nonatomic,copy) NSArray *imgArray;
/** titleArray */
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation HYMineInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleArray = @[@"我的账户",@"优惠券",@"我的地址",@"我的二维码",@"意见反馈",@"联系客服"];
        _imgArray = @[@"mine_myAccount",@"mine_discountCoupon",@"mine_myAddress",@"mine_qrCode",@"mine_feedback",@"mine_myAddress"];
         
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    CGFloat itemWidth = KSCREEN_WIDTH / 4;
    CGFloat itemHeight = 45 * WIDTH_MULTIPLE;
    CGFloat itemMargin = 23 * WIDTH_MULTIPLE;
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        
        HYButton *button = [HYButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_imgArray[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake((i % 4) * itemWidth, (i / 4) * (itemHeight + itemMargin) + 20 * WIDTH_MULTIPLE, itemWidth, itemHeight);
        button.titleLabel.font = KFitFont(14);
        [button setTitleColor:KCOLOR(@"272727") forState:UIControlStateNormal];
        [self addSubview:button];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

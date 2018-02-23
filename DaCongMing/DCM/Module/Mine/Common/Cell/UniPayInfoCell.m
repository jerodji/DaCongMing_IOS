//
//  UniPayInfoCell.m
//  DaCongMing
//
//  Created by hailin on 2018/2/2.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "UniPayInfoCell.h"

@interface UniPayInfoCell()
//@property (nonatomic,assign) CGRect rectFrame;
@end

@implementation UniPayInfoCell

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        self = [[self class] loadXIB];
//        _rectFrame = frame;
//
//    }
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];

    _titleLab.font = KFont(18);
    _cardIdLab.font = KFont(25);
}

//- (void)drawRect:(CGRect)rect {
//    self.frame = _rectFrame;
//}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end

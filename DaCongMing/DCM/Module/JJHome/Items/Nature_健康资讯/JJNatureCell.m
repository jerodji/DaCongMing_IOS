//
//  JJNatureCell.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJNatureCell.h"

@implementation JJNatureCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [JJNatureCell loadXIB];
        self.rectFrame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.shadowColor = UIColorRGB(83, 83, 83).CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowRadius = 10;
    self.backView.layer.cornerRadius = 10;
    [self.imgView layerCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft withRadiiSize:CGSizeMake(10, 10) viewRect:self.imgView.frame];
}

- (void)drawRect:(CGRect)rect {
    self.frame = self.rectFrame;
}

- (void)setModel:(JJNatureModel *)model {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.titleLabel.text = model.title;
}

- (IBAction)btnClick:(id)sender {
    !_btnCB ? : _btnCB();
}

@end

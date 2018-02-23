//
//  JJTimeReCCell.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJTimeReCCell.h"

@interface JJTimeReCCell()
{
    double startTS;
    double endTS;
}
@property (nonatomic, assign) CGRect rect;
@end

@implementation JJTimeReCCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotyTimeUpdate object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [JJTimeReCCell loadXIB];
        self.rect = frame;
        self.frame = frame;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTime:) name:NotyTimeUpdate object:nil];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowColor = UIColorRGB(83, 83, 83).CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 10;
    
    self.backView.layer.cornerRadius = 10;
    
    [self.itemImage layerCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadiiSize:CGSizeMake(10, 10) viewRect:self.itemImage.frame];
    self.itemImage.layer.masksToBounds = YES;
}

- (void)drawRect:(CGRect)rect {
    self.frame = self.rect;
}

- (void)updateTime:(NSNotification*)noty {

    if (IsNull(self.model)) return;
    if (IsNull(self.model.startTime)) return;
    if (IsNull(self.model.endTime))   return;
    if (IsNull(self.publicityLabel))  return;
    
    double nowTS   = [JJTimeStamp timeStampNow];

    if (nowTS <= startTS) {
        // **** 后开始
        double cha = startTS - nowTS;
        NSString* s = [JJTimeStamp dd_HH_MM_SS_timeWithSeconds:cha];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.publicityLabel.text = [NSString stringWithFormat:@"%@ 后开始",s];
        });
        
    }
    if (( startTS < nowTS)&&(nowTS <= endTS)) {
        // **** 后结束
        double cha = endTS - nowTS;
        NSString* s = [JJTimeStamp dd_HH_MM_SS_timeWithSeconds:cha];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.publicityLabel.text = [NSString stringWithFormat:@"%@ 后结束",s];
//            NSLog(@"2 %p %@",self,s);
        });
    }
    if (nowTS>endTS) {
        //
        dispatch_async(dispatch_get_main_queue(), ^{
            self.publicityLabel.text = @"活动已结束";
        });
    }

}

- (void)setModel:(JJTimeReCModel *)model
{
    _model = model; /* 设置自己的model */
    
    startTS = [JJTimeStamp timeStampWithDateStr:model.startTime style:DateStyle_yyyy_MM_dd_HH_mm_ss];
    endTS   = [JJTimeStamp timeStampWithDateStr:model.endTime style:DateStyle_yyyy_MM_dd_HH_mm_ss];
    
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:model.itemTitleImage]];
    
    ///----- price -----
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:@"¥"];
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:model.price]];
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"¥"]];
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:model.originalPrice]];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName:UIColorRGB(56, 57, 56)
                            ,NSFontAttributeName: [UIFont fontWithName:FONT_DINOT size:13]
                            }
                    range:NSMakeRange(0, 1+model.price.length)];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName: UIColorRGB(136, 136, 136)
                            ,NSFontAttributeName: [UIFont fontWithName:FONT_DINOT size:8]
                            //,NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)
                            ,NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)
                            //,NSBaselineOffsetAttributeName : @0
                            }
                    range:NSMakeRange(1+model.price.length+1+1 -1, 1+model.originalPrice.length)];
    
    self.priceLabel.attributedText = attStr;
    
    //--------
    self.nameLabel.text = model.itemName;
    
    if (_delegate && [_delegate respondsToSelector:@selector(updateTimeForCell:model:)]) {
        [_delegate updateTimeForCell:self model:model];
    }
    
    self.publicityLabel.text = @"";//[model.startTime substringToIndex:16];
}

@end

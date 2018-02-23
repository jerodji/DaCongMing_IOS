//
//  JJHotInStoreCell.m
//  DaCongMing
//
//  Created by hailin on 2018/1/24.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJHotInStoreCell.h"

@interface JJHotInStoreCell()
@property (nonatomic, assign) CGRect frameRect;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation JJHotInStoreCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [JJHotInStoreCell loadXIB];
        self.frameRect = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = self.frameRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setModel:(JJHotInStoreModel *)model {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.itemTitleImage]];
    _nameLabel.text = model.itemName;
    
    NSAttributedString* attStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",model.price]
                                                                 attributes:@{
        NSForegroundColorAttributeName : UIColorRGB(56, 57, 56)
        ,NSFontAttributeName : [UIFont fontWithName:FONT_DINOT size:13]
        }];
    _priceLabel.attributedText = attStr;
    _priceLabel.textAlignment = NSTextAlignmentCenter;
}

@end

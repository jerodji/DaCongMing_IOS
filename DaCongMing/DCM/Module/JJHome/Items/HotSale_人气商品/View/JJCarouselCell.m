//
//  JJCarouselCell.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJCarouselCell.h"
#import "UIImage+AttributeImage.h"

@interface JJCarouselCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabelk;
@property (weak, nonatomic) IBOutlet UILabel *publicityLabel;
@property (weak, nonatomic) IBOutlet UIButton *gwcBtn;
@end

@implementation JJCarouselCell

- (void)setModel:(JJCarouselCellModel *)model
{
    //// image
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.itemTitleImage]];
    
    ////----- price -----
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:@"¥"];
    if (!model.price || ([model.price floatValue]<0.0)) {
        model.price = @"0.0";
    }
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:model.price]];
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:@" "]];
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"¥"]];
    [attStr appendAttributedString:[[NSAttributedString alloc]initWithString:model.originalPrice]];
    [attStr addAttributes:@{
                            NSForegroundColorAttributeName:UIColorRGB(254, 82, 69)
                            ,NSFontAttributeName: [UIFont fontWithName:FONT_DINOT size:15]
                            }
                    range:NSMakeRange(0, 1+model.price.length)];
    [attStr addAttributes:@{
                            NSForegroundColorAttributeName: [UIColor clearColor]
                            ,NSFontAttributeName: [UIFont fontWithName:FONT_DINOT size:8]
//                            ,NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)
                            ,NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)
//                            ,NSBaselineOffsetAttributeName : @0
                            }
                    range:NSMakeRange(1+model.price.length+1+1 -1, 1+model.originalPrice.length)];
    self.priceLabel.attributedText = attStr;
    
    ////-----  name -----
    NSMutableAttributedString* name = [[NSMutableAttributedString alloc] initWithString:@""];
    //国家
    UILabel* label = [[UILabel alloc] init];
    label.text = model.origin;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:8];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    [label sizeToFit];
    CGSize size = CGSizeMake(label.size.width+4, label.size.height+2);
    label.frame = CGRectMake(self.nameLabelk.frame.origin.x, self.nameLabelk.origin.y + 3, size.width, size.height);
    label.layer.cornerRadius = 2.5;
    label.layer.masksToBounds = YES;
    [self.backView addSubview:label];
    //名称
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
//    paragraphStyle.maximumLineHeight = 60;  //最大的行高
//    paragraphStyle.lineSpacing = 5;  //行自定义行高度
    [paragraphStyle setFirstLineHeadIndent:size.width + 2];//首行缩进 根据label在加2个像素
    
    [name appendString:model.itemName];
    [name addAttributes:@{
                          NSForegroundColorAttributeName : UIColorRGB(39, 39, 39)
                          ,NSFontAttributeName : [UIFont systemFontOfSize:12]
                          ,NSParagraphStyleAttributeName: paragraphStyle
                          }
                  range:NSMakeRange(0, model.itemName.length)];
    self.nameLabelk.attributedText = name;
    
    ////-----  publicity -----
    self.publicityLabel.text = model.publicity;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.gwcBtn addTarget:self action:@selector(addToCartAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowRadius = 13;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(0, 0);
//    self.layer.shadowPath =
//    self.layer.masksToBounds = YES;
    
    self.backView.layer.cornerRadius = 13;
    self.backView.layer.masksToBounds = YES;
    
}

//加入购物车
- (void)addToCartAction:(UIButton*)button {
    NSLog(@"加入购物车");
    !_addCartCB ? : _addCartCB();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

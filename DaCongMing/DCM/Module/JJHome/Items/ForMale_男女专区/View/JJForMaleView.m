//
//  JJForMaleView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/22.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJForMaleView.h"

@interface JJForMaleView()///<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;
@end

@implementation JJForMaleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftImgView.layer.cornerRadius = 10;
    self.leftImgView.layer.masksToBounds = YES;
    self.rightImgView.layer.cornerRadius = 10;
    self.rightImgView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer* tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftAction:)];
    self.leftImgView.userInteractionEnabled = YES;
    [self.leftImgView addGestureRecognizer:tapLeft];
    
    UITapGestureRecognizer* rightLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightAction:)];
    self.rightImgView.userInteractionEnabled = YES;
    [self.rightImgView addGestureRecognizer:rightLeft];
    
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.frame = CGRectMake(0, TitleViewHeight, KSCREEN_WIDTH, HeightForMale);
}

- (void)tapLeftAction:(UITapGestureRecognizer*)tapGesture {
    NSLog(@"%@",self.modelArray[0].jumpUrl);
    [DCURLRouter pushURLString:self.modelArray[0].jumpUrl animated:YES];
}
- (void)tapRightAction:(UITapGestureRecognizer*)tapGesture {
    NSLog(@"%@",self.modelArray[1].jumpUrl);
    [DCURLRouter pushURLString:self.modelArray[1].jumpUrl animated:YES];
}

- (void)updateUI {
    if (NotNull([_modelArray objectAtIndex:0])) {
        JJForMaleModel* leftModel = [_modelArray objectAtIndex:0];
        [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:leftModel.imageUrl]];
    }
    if (NotNull([_modelArray objectAtIndex:1])) {
        JJForMaleModel* rightModel = [_modelArray objectAtIndex:1];
        [self.rightImgView sd_setImageWithURL:[NSURL URLWithString:rightModel.imageUrl]];
    }
}




@end

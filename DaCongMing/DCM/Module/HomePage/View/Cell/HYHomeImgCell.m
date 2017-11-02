//
//  HYHomeImgCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeImgCell.h"

@implementation HYHomeImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.imgView];
        
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.left.equalTo(self).offset(10);
            make.bottom.right.equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (void)setImgUrl:(NSString *)imgUrl{

    _imgUrl = imgUrl;
    self.cellHeight = 0.f;

    
    __block CGFloat originalImageWidth = 0;
    __block CGFloat originalImageHeight = 0;
    __block CGFloat imageScale = 0;
    __block CGFloat imageWidth = KSCREEN_WIDTH;
    __block CGFloat imageHeight = imageWidth * imageScale;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        originalImageWidth = image.size.width;
        originalImageHeight = image.size.height;
        imageScale = originalImageHeight / originalImageWidth;
        imageWidth = KSCREEN_WIDTH;
        imageHeight = imageWidth * imageScale;
        
        _cellHeight = imageHeight + 20;
    }];
}

#pragma mark - lazyload
- (UIImageView *)imgView{
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@"productPlaceholder"]];
    }
    
    return _imgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

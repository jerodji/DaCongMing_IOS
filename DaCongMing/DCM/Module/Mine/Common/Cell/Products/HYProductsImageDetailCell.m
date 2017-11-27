//
//  HYProductsImageDetailCell.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYProductsImageDetailCell.h"

@interface HYProductsImageDetailCell()

/** label */
@property (nonatomic,strong) UILabel *promiseLabel;
/** 上拉Label */
@property (nonatomic,strong) UILabel *pullLabel;
/**上一张图片的高度*/
@property (nonatomic,assign) CGFloat previousImgHeight;

@end

@implementation HYProductsImageDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //[self addSubview:self.promiseLabel];
        [self addSubview:self.pullLabel];
        
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = imageArray;
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.previousImgHeight = 50 * WIDTH_MULTIPLE;
    
    for (NSInteger i = 0; i < _imageArray.count; i++) {
        
        UIImageView *imageView = [UIImageView new];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:[UIImage imageNamed:@"productPlaceholder"]];
        
       __block CGFloat originalImageWidth = 0;
       __block CGFloat originalImageHeight = 0;
       __block CGFloat imageScale = 0;
       __block CGFloat imageWidth = KSCREEN_WIDTH;
       __block CGFloat imageHeight = imageWidth * imageScale;
        
        if (_imageArray[i]) {
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:[UIImage imageNamed:@"productPlaceholder"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                originalImageWidth = image.size.width != 0 ? image.size.width : 1;
                originalImageHeight = image.size.height;
                imageScale = originalImageHeight / originalImageWidth;
                imageWidth = KSCREEN_WIDTH;
                imageHeight = imageWidth * imageScale;
                
                
                imageView.frame = CGRectMake(0, _previousImgHeight, imageWidth, imageHeight);
                //上一张图片的高度
                _previousImgHeight = imageHeight + _previousImgHeight;
                [self addSubview:imageView];
                
                imageView.userInteractionEnabled = YES;
                imageView.tag = i;
                //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
                //        [imageView addGestureRecognizer:tap];
                //cell的高度
                _height = imageView.frame.origin.y + imageView.height + 10 * WIDTH_MULTIPLE;
            }];
        }
        
    }
}

- (void)layoutSubviews{
    
    
//    [_promiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self).offset(10 * WIDTH_MULTIPLE);
//        make.right.equalTo(self);
//        make.top.equalTo(self).offset(15);
//        make.height.equalTo(@(20 * WIDTH_MULTIPLE));
//    }];
    
    [_pullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@(50 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - lazyload
- (UILabel *)promiseLabel{
    
    if (!_promiseLabel) {
        
        _promiseLabel = [[UILabel alloc] init];
        _promiseLabel.font = KFitFont(15);
        _promiseLabel.textAlignment = NSTextAlignmentLeft;
        _promiseLabel.text = @"承诺:            ";
        _promiseLabel.textColor = KCOLOR(@"7b7b7b");
    }
    return _promiseLabel;
}

- (UILabel *)pullLabel{
    
    if (!_pullLabel) {
        
        _pullLabel = [[UILabel alloc] init];
        _pullLabel.font = KFitFont(12);
        _pullLabel.textAlignment = NSTextAlignmentCenter;
        _pullLabel.backgroundColor = KCOLOR(@"f6f6f6");
        _pullLabel.text = @"————  继续拖动，查看产品详情  ————";
        _pullLabel.textColor = KAPP_b7b7b7_COLOR;
    }
    return _pullLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

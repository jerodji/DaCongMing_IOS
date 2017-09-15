//
//  HYPhotoBrowseView.m
//  FlowerHan
//
//  Created by Jackhu on 2017/5/5.
//  Copyright © 2017年 Jackhu. All rights reserved.
//

#define MaxenlargeScale         2.0
#define MinreduceScale          0.5

#import "HYPhotoBrowseView.h"


@interface HYPhotoBrowseView() <UIScrollViewDelegate>

/**左划手势*/
@property (nonatomic,strong) UISwipeGestureRecognizer *leftSwipe;
/**右划手势*/
@property (nonatomic,strong) UISwipeGestureRecognizer *rightSwipe;
/**scrollView*/
@property (nonatomic,strong) UIScrollView *scrollView;
/**索引值label*/
@property (nonatomic,strong) UILabel *indexLabel;
/**放缩比例*/
@property (nonatomic,assign) CGFloat lastScale;
/**imageViewArray*/
@property (nonatomic,strong) NSMutableArray *imageViewArray;
/**上一次滑动的index*/
@property (nonatomic,assign) NSInteger lastIndex;

@end

@implementation HYPhotoBrowseView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.scrollView];
        [self addSubview: self.indexLabel];
        _imageViewArray = [NSMutableArray array];
        
        self.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didmissView)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UILabel *)indexLabel{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH - 80) / 2, KSCREEN_HEIGHT - 100, 80, 40)];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.font = KFitFont(16);
    }
    return _indexLabel;
}



- (void)setPhotoArray:(NSArray *)photoArray{
    
    _photoArray = photoArray;
    _scrollView.contentSize = CGSizeMake(KSCREEN_WIDTH * photoArray.count, KSCREEN_HEIGHT);
    for (NSInteger i = 0; i < photoArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KSCREEN_WIDTH, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        [imageView sd_setImageWithURL:photoArray[i]];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
        
        UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(imagePinch:)];
        [imageView addGestureRecognizer:pinchGes];
        [_imageViewArray addObject:imageView];
    }

}

- (void)setIndex:(NSInteger)index{
    
    _index = index;
    _lastIndex = index;
    [_scrollView setContentOffset:CGPointMake(index * KSCREEN_WIDTH, 0)];
    _indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,_photoArray.count];
    
}

- (void)imagePinch:(UIPinchGestureRecognizer *)sender{

    NSLog(@"%f",sender.scale);
    if (sender.scale > 1.0) {
        //放大
        if (sender.scale > MaxenlargeScale) {
            return ;
        }
    }
    else{
        //缩小
        if (sender.scale < MinreduceScale) {
            return;
        }
    }
    
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    _lastScale = sender.scale;
    sender.scale = 1;
}

#pragma mark ********ScrollViewDelegate********
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIImageView *imageView = _imageViewArray[_lastIndex];
    [UIView animateWithDuration:0.5 animations:^{
        
        imageView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    NSInteger selectIndex = scrollView.contentOffset.x / KSCREEN_WIDTH;
    _indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",selectIndex+1,_photoArray.count];
    _lastIndex = selectIndex;
}

- (void)didmissView{

//    UIImageView *imageView = _imageViewArray[_lastIndex];
    [UIView animateWithDuration:0.5 animations:^{
        
        [self removeFromSuperview];
    }];
    
}

@end

//
//  JJTimeReCView.m
//  DaCongMing
//
//  Created by hailin on 2018/1/23.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJTimeReCView.h"
#import "iCarousel.h"

static NSString* TIMEREC_CELLID = @"TIMEREC_CELLID";

@interface JJTimeReCView()<iCarouselDelegate, iCarouselDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TimeReCUpdateTimeListener>
@property (nonatomic, strong) NSMutableArray<JJTimeReCModel*>* modelArray;
@property (nonatomic, strong) iCarousel * carousel;
@property (nonatomic, strong) UICollectionView* colecView;
@property (nonatomic,strong) JJTimer * timer;
@end

@implementation JJTimeReCView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray*)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.modelArray = [[NSMutableArray alloc] initWithArray:dataArr];
        [self configColecViewWithFrame:frame];
        [self configTimer];
    }
    return self;
}

- (JJTimer *)timer {
    if (!_timer) {
        _timer = [[JJTimer alloc] init];
    }
    return _timer;
}

- (void)viewWillAppear {
}

- (void)configColecViewWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //flowLayout.minimumInteritemSpacing = 0;
    _colecView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, frame.size.height) collectionViewLayout:flowLayout];
    _colecView.delegate = self;
    _colecView.dataSource = self;
    _colecView.scrollEnabled = YES;
    _colecView.showsVerticalScrollIndicator = NO;
    _colecView.showsHorizontalScrollIndicator = NO;
    [_colecView registerClass:[JJTimeReCCell class] forCellWithReuseIdentifier:TIMEREC_CELLID];
    _colecView.backgroundColor = [UIColor clearColor];
    _colecView.clipsToBounds = NO;
    _colecView.layer.masksToBounds = NO;
    [self addSubview:_colecView];
}

- (void)configTimer {
    
    if (IsNull(_modelArray)) {
        return;
    }
    
    __block double maxTS = 0;
    for (int i=0; i<_modelArray.count; i++) {
        JJTimeReCModel* model = [_modelArray objectAtIndex:i];
        double ts =  [JJTimeStamp timeStampWithDateStr:model.endTime style:DateStyle_yyyy_MM_dd_HH_mm_ss];
        if (ts > maxTS) {
            maxTS = ts;
        }
    }
    
    if (!self.timer) {
         self.timer = [[JJTimer alloc] init];
    }
    
    double interv = 1.0;
    [self.timer taskWithInterval:interv action:^{
        maxTS -= interv;
        double cha = maxTS;
        if (cha <= 0) {
            [self.timer cancelGCDTimer];
            return;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotyTimeUpdate object:nil];
    }];
    [self.timer beginGCDTimer];
    
}

- (void)updateTimeForCell:(JJTimeReCCell *)cell model:(JJTimeReCModel *)model {
    NSLog(@"555 %@",cell);
}

- (void)updateUI {
    if (self.carousel) {
        [self.carousel reloadData];
    }
    if (self.colecView) {
        [self.colecView reloadData];
    }
}

#pragma mark- collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JJTimeReCModel* model = [_modelArray objectAtIndex:indexPath.row];
    JJTimeReCCell* cell   = [collectionView dequeueReusableCellWithReuseIdentifier:TIMEREC_CELLID forIndexPath:indexPath];
    cell.delegate = self;
    [cell setModel:model];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

//  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    JJTimeReCModel* model = [self.modelArray objectAtIndex:indexPath.row];
    NSLog(@">> %@",model.jumpUrl);
    [DCURLRouter pushURLString:model.jumpUrl animated:YES];
}

//  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return  CGSizeMake(_colecView.frame.size.width/3.0, self.frame.size.height/2.0-15-20);
    return CGSizeMake(116, 170);
}

//  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;//(self.colecView.bounds.size.width - 116*3)/2.0f;
}


#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.modelArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    JJTimeReCCell* cellView = [[JJTimeReCCell alloc] initWithFrame:CGRectMake(0, 0, 116, 170)];
    
    if (index < self.modelArray.count) {
        [cellView setModel:_modelArray[index]];
    }
    
    return cellView;
}

#pragma mark iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
//    if (self.modelArray.count <= 6) {
//        return 200;
//    }
    return 150;
}

//- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
//
//}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了,jumpURL == %@",[self.modelArray objectAtIndex:index].jumpUrl);
    [DCURLRouter pushURLString:[self.modelArray objectAtIndex:index].jumpUrl animated:YES];
}



@end

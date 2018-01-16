
//
//  HYMyOrderViewController.m
//  DaCongMing
//
//

#import "HYMyOrderViewController.h"
#import "HYMyOrderTitleView.h"
#import "HYMyOrderChildViewController.h"

static NSString *cellIdentifier = @"collectionCellIdentifer";

@interface HYMyOrderViewController () <UICollectionViewDelegate,UICollectionViewDataSource,MyOrderTitleChangedDelegate>

/** titleView */
@property (nonatomic,strong) HYMyOrderTitleView *titleView;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HYMyOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"我的订单";
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.collectionView];
    
}

- (void)setSelectTag:(NSInteger)selectTag{
    
    _selectTag = selectTag;
    
    [self setupSubviews];
    if (self.childViewControllers) {
        
//        [self titleChanged:selectTag];
        _titleView.previousSelectIndex = selectTag;
    }
}

#pragma mark - collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //移除子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //添加控制器
    HYMyOrderChildViewController *vc = self.childViewControllers[indexPath.item];
    //设置控制器的View
    [vc.view setFrame:CGRectMake(0, 0, collectionView.width, collectionView.height)];
    [cell.contentView addSubview:vc.view];
    
    return cell;
}


#pragma mark - titleViewDelegate
- (void)titleChanged:(NSInteger)index{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.collectionView setContentOffset:CGPointMake(index * KSCREEN_WIDTH, 0)];
    }];
    HYMyOrderChildViewController *vc = self.childViewControllers[index];
    vc.tag = index;
}


#pragma mark - scrollViewDelete
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > (self.childViewControllers.count - 1) * KSCREEN_WIDTH) {
        
        scrollView.scrollEnabled = NO;
    }
    else{
        
        scrollView.scrollEnabled = YES;
    }
    
}

//减速完成时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / KSCREEN_WIDTH;
    _titleView.previousSelectIndex = index;
}

#pragma mark - lazyload
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat itemHeight = KSCREEN_HEIGHT - KNAV_HEIGHT;
        flowLayout.itemSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT - 45 * WIDTH_MULTIPLE - KNAV_HEIGHT);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, KSCREEN_WIDTH, KSCREEN_HEIGHT - 45 * WIDTH_MULTIPLE - KNAV_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    return _collectionView;
}

- (HYMyOrderTitleView *)titleView{
    
    if (!_titleView) {
        
        NSArray *arr = @[@"全部",@"待支付",@"待发货",@"待收货",@"已收货"];
        _titleView = [[HYMyOrderTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 45 * WIDTH_MULTIPLE) WithTitleArray:arr];
        _titleView.delegate = self;
        
        for (NSInteger i = 0; i < arr.count; i++) {
            
            HYMyOrderChildViewController *vc = [[HYMyOrderChildViewController alloc] init];
            [self addChildViewController:vc];
        }
        
        [self.view addSubview:self.collectionView];
    }
    return _titleView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end

//
//  HYGoodsListViewController.m
//  DaCongMing
//
//

#import "HYGoodsListViewController.h"

#import "HYGoodsItemCollectionViewCell.h"
#import "HYGoodsDetailInfoViewController.h"



@interface HYGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource>

/**记录最后一次点击的按钮*/
@property (nonatomic,strong) UIButton *previousSelectBtn;
/** hor */
@property (nonatomic,strong) UIView *horizonLine;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;
/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** 请求的页数 */
@property (nonatomic,assign) NSInteger pageCount;
/** 当前请求的类型 */
@property (nonatomic,assign) HYGoodsListType requestType;
/** 是否选择销量排序 */
@property (nonatomic,assign) BOOL isSalesSelect;
/** 是否选择价格排序 */
@property (nonatomic,assign) BOOL isPriceSelect;

@end

@implementation HYGoodsListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageCount = 1;
    self.requestType = HYGoodsListTypeDefault;
    
    [self setupTopButtons];
    [self setupSubviews];
    [self requestGoodsListWithSortType:self.requestType];

}

- (void)viewSafeAreaInsetsDidChange{
    
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"safeAreaInsets:%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
    NSLog(@"additionalSafeAreaInsets:%@",NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));
    
}

- (void)setupSubviews{
    
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.horizonLine];
    [self.view addSubview:self.collectionView];
    
    self.title = self.title != nil ? self.title : @"商品列表";
}

- (void)setupTopButtons{
    
    NSArray *titleArr = @[@"默认",@"价格",@"销量"];
    CGFloat width = self.view.width / titleArr.count;
    for (NSInteger i = 0; i < titleArr.count ; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 35)];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"default_arrow_down"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"default_arrow_up"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:KCOLOR(@"7b7b7b") forState:UIControlStateNormal];
        [button setTitleColor:KCOLOR(@"272727") forState:UIControlStateSelected];
        [button addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"shadow_l"] forState:UIControlStateHighlighted];
        button.tag = i + 10;
        button.titleLabel.font = KFitFont(14);
        
        UIImage *image = button.imageView.image;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width - 6, 0, image.size.width + 6)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width + 6, 0, -button.titleLabel.bounds.size.width - 6)];
        [self.view addSubview:button];
        
        if (button.tag == 10) {
            
            button.selected = YES;
        }
    }
    
    CGFloat buttonOrigin = (35 - 15 * WIDTH_MULTIPLE) / 2;
    for (NSInteger i = 0; i < 2; i++) {
        
        UIView *line = [UIView new];
        line.backgroundColor = KAPP_7b7b7b_COLOR;
        line.frame = CGRectMake(width * i + width, buttonOrigin, 1, 15 * WIDTH_MULTIPLE);
        [self.view addSubview:line];
    }
}

- (void)viewDidLayoutSubviews{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(self.horizonLine.bottom);
    }];
}

#pragma mark - networkRequest
- (void)requestGoodsListWithSortType:(HYGoodsListType)sortType{
    
    [_datalist removeAllObjects];
    self.pageCount = 1;
    NSString *sortTypeStr = [NSString stringWithFormat:@"%lu",(unsigned long)sortType];
    [HYGoodsHandle requestGoodsListItem_type:self.type pageNo:1 sortType:sortTypeStr keyword:self.keyword complectionBlock:^(NSArray *datalist) {
       
        if (datalist) {
            
            [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:obj];
                [self.datalist addObject:model];
            }];
            [_collectionView reloadData];
            
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];

    }];
}

#pragma mark - refresh & reloadDataMore
- (void)refreshData{
    
    [self requestGoodsListWithSortType:self.requestType];
}

- (void)reloadDataMore{
    
    self.pageCount += 1;
    NSString *sortTypeStr = [NSString stringWithFormat:@"%lu",(unsigned long)self.requestType];
    [HYGoodsHandle requestGoodsListItem_type:_type pageNo:self.pageCount sortType:sortTypeStr keyword:self.keyword complectionBlock:^(NSArray *datalist)  {
        
        if (datalist.count) {
            
            [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:obj];
                [self.datalist addObject:model];
            }];
            [_collectionView reloadData];
            [_collectionView.mj_footer endRefreshing];
        }
        else{
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
    }];
}


#pragma mark - action
- (void)topButtonAction:(UIButton *)button{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.horizonLine.frame = CGRectMake(button.left, button.bottom, button.width, 2);
    }];
    
    self.requestType = button.tag - 10;
    if (button.tag == 0) {
        
        self.requestType = HYGoodsListTypeDefault;
    }
   
    if (button.tag == 11) {
        
        NSString *imageName = _isSalesSelect ? @"default_arrow_up" : @"default_arrow_down";
        self.requestType = _isSalesSelect ? HYGoodsListTypeSalesVolumeAesc : HYGoodsListTypeSalesVolumeDesc;
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        _isSalesSelect = !_isSalesSelect;
    }
    
    if (button.tag == 12) {
        
        NSString *imageName = _isPriceSelect ? @"default_arrow_up" : @"default_arrow_down";
        self.requestType = _isPriceSelect ? HYGoodsListTypePriceAesc : HYGoodsListTypePriceDesc;
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        _isPriceSelect = !_isPriceSelect;
    }
    _previousSelectBtn.selected = NO;
    button.selected = YES;
    _previousSelectBtn = button;
    
    [self requestGoodsListWithSortType:self.requestType];
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemCollectionViewCell *cell = (HYGoodsItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];

    HYGoodsItemModel *itemModel = self.datalist[indexPath.item];
    cell.goodsModel = itemModel;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemModel *itemModel = self.datalist[indexPath.item];

    HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
    detailVC.navigationController.navigationBar.hidden = YES;
    detailVC.goodsID = itemModel.item_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}



//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    HYGoodsItemModel *itemModel = self.datalist[indexPath.item];
//    CGFloat itemWidth = (KSCREEN_WIDTH - 15 * WIDTH_MULTIPLE) / 2.0;
//    return CGSizeMake(itemWidth, itemModel.cellHeight ? itemModel.cellHeight : 325 * WIDTH_MULTIPLE);
//}

#pragma mark - 没有数据
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"目前没有产品";
    NSDictionary *attributes = @{NSFontAttributeName : KFitFont(18),NSForegroundColorAttributeName : KAPP_7b7b7b_COLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    UIImage *image = [UIImage imageNamed:@"noOrder"];
    return image;
}

#pragma mark - lazyload
- (UIView *)horizonLine{
    
    if (!_horizonLine) {
        
        _horizonLine = [[UIView alloc] initWithFrame:CGRectMake(0, 35, self.view.width / 3, 2)];
        _horizonLine.backgroundColor = KCOLOR(@"383938");
    }
    return _horizonLine;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.estimatedItemSize = CGSizeMake((KSCREEN_WIDTH - 15) / 2, KItemHeight - 10);
//        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
//        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 10 * WIDTH_MULTIPLE;      //纵向间距
        layout.sectionInset = UIEdgeInsetsMake(10, 5 , 0, 5);
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setCollectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
        
        [_collectionView registerClass:[HYGoodsItemCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        _collectionView.emptyDataSetSource = self;
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadDataMore)];
        _collectionView.mj_footer = footer;
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



@end

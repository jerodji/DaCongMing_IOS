//
//  HYGoodsListViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/20.
//  Copyright © 2017年 胡勇. All rights reserved.
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

@end

@implementation HYGoodsListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageCount = 1;
    self.requestType = HYGoodsListTypeDefault;
    
    [self setupTopButtons];
    [self setupSubviews];
    [self requestGoodsDefaultList];

}

- (void)setupSubviews{
    
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.horizonLine];
    [self.view addSubview:self.collectionView];
}

- (void)setupTopButtons{
    
    NSArray *titleArr = @[@"默认",@"销量",@"价格"];
    CGFloat width = self.view.width / titleArr.count;
    for (NSInteger i = 0; i < titleArr.count ; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 35)];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"default_arrow_down"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"default_arrow_up"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:KCOLOR(@"7b7b7b") forState:UIControlStateNormal];
        [button setTitleColor:KCOLOR(@"272727") forState:UIControlStateSelected];
        [button addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
        
        UIImage *image = button.imageView.image;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width - 6, 0, image.size.width + 6)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width + 6, 0, -button.titleLabel.bounds.size.width - 6)];
        [self.view addSubview:button];
        
        if (button.tag == 10) {
            
            button.selected = YES;
        }
    }
}

#pragma mark - networkRequest
- (void)requestGoodsDefaultList{
    
    [_datalist removeAllObjects];
    self.pageCount = 1;
    [HYGoodsHandle requestGoodsListItem_type:_type pageNo:1 andPage:5 order:nil hotsale:@"ture" complectionBlock:^(NSArray *datalist) {
       
        if (datalist) {
            
            [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:obj];
                model.cellHeight = 333 * WIDTH_MULTIPLE;
                [self.datalist addObject:model];
            }];
            [_collectionView reloadData];
            
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];

    }];
}

- (void)requestGoodsPriceDescList{
    
    [_datalist removeAllObjects];
    self.pageCount = 1;
    [HYGoodsHandle requestGoodsListItem_type:_type pageNo:1 andPage:5 order:@"descending" hotsale:@"ture" complectionBlock:^(NSArray *datalist) {
        
        [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:obj];
            [self.datalist addObject:model];
        }];
        
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        
    }];
}

- (void)requestGoodsPriceAscList{
    
    [_datalist removeAllObjects];
    self.pageCount = 1;
    [HYGoodsHandle requestGoodsListItem_type:_type pageNo:1 andPage:5 order:@"Ascending" hotsale:@"ture" complectionBlock:^(NSArray *datalist) {
        
        [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:obj];
            [self.datalist addObject:model];
        }];
        [_collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - refresh & reloadDataMore
- (void)refreshData{
    
    switch (self.requestType) {
        case HYGoodsListTypeDefault:
            
            [self requestGoodsDefaultList];
            break;
        case HYGoodsListTypeAesc:
            
            [self requestGoodsPriceAscList];
            break;
        case HYGoodsListTypeDesc:
            
            [self requestGoodsPriceDescList];
            break;
        default:
            break;
    }
}

- (void)reloadDataMore{
    
    self.pageCount += 1;
    [HYGoodsHandle requestGoodsListItem_type:_type pageNo:self.pageCount andPage:5 order:nil hotsale:@"ture" complectionBlock:^(NSArray *datalist) {
        
        if (datalist.count) {
            
            [self.datalist addObjectsFromArray:datalist];
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
    
    _previousSelectBtn.selected = NO;
    button.selected = YES;
    _previousSelectBtn = button;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.horizonLine.frame = CGRectMake(button.left, button.bottom, button.width, 2);
    }];
    
    self.requestType = button.tag - 10;
    [self refreshData];
   
}

#pragma mark - collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _datalist.count;
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYGoodsItemModel *itemModel = self.datalist[indexPath.item];
    return CGSizeMake(KSCREEN_WIDTH / 2 - 10, itemModel.cellHeight);
}

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
//        layout.itemSize = CGSizeMake(KSCREEN_WIDTH / 2 - 10, 346 * WIDTH_MULTIPLE);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 6 * WIDTH_MULTIPLE;      //纵向间距
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.horizonLine.bottom + 6 * WIDTH_MULTIPLE, KSCREEN_WIDTH, KSCREEN_HEIGHT - 40 - 64) collectionViewLayout:layout];
        [_collectionView setCollectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_TableView_BgColor;
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

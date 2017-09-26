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

@interface HYGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**记录最后一次点击的按钮*/
@property (nonatomic,strong) UIButton *previousSelectBtn;

/** hor */
@property (nonatomic,strong) UIView *horizonLine;

/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYGoodsListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTopButtons];
    [self setupSubviews];
    [self requestGoodsDefaultList];

}

- (void)setupSubviews{
    
    [self.view addSubview:self.horizonLine];
    [self.view addSubview:self.collectionView];
}

- (void)setupTopButtons{
    
    NSArray *normalImgArr = @[@"default_arrow_right",@"price_arrow_down"];
    NSArray *selectImgArr = @[@"default_arrow_down", @"price_arrow_up"];
    NSArray *titleArr     = @[@"默认",@"价格"];
    CGFloat width = self.view.width / 2;
    for (NSInteger i = 0; i < normalImgArr.count ; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 35)];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:normalImgArr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImgArr[i]] forState:UIControlStateSelected];
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
    [HYGoodsHandle requestGoodsListItem_type:_type pageNo:1 andPage:5 order:nil hotsale:@"ture" complectionBlock:^(NSArray *datalist) {
       
        [self.datalist addObjectsFromArray:datalist];
        [_collectionView reloadData];
    }];
}

- (void)requestGoodsPriceList{
    
    [_datalist removeAllObjects];
    [HYGoodsHandle requestGoodsListItem_type:_type pageNo:1 andPage:5 order:@"Ascending" hotsale:@"ture" complectionBlock:^(NSArray *datalist) {
        
        [self.datalist addObjectsFromArray:datalist];
        [_collectionView reloadData];
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
    
    if (button.tag == 10) {
    
        [self requestGoodsDefaultList];
    }
    else{
    
        [self requestGoodsPriceList];
    }
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
    
    NSDictionary *dict = _datalist[indexPath.item];
    cell.goodsModel = [HYGoodsItemModel modelWithDictionary:dict];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((KSCREEN_WIDTH - 10) / 2, 340 * WIDTH_MULTIPLE);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _datalist[indexPath.item];
    HYGoodsItemModel *model = [HYGoodsItemModel modelWithDictionary:dict];
    
    DLog(@"current itemID is %@",model.item_id);

    
    HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
    detailVC.navigationController.navigationBar.hidden = YES;
    detailVC.goodsID = model.item_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark - lazyload
- (UIView *)horizonLine{
    
    if (!_horizonLine) {
        
        _horizonLine = [[UIView alloc] initWithFrame:CGRectMake(0, 35, self.view.width / 2, 2)];
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.horizonLine.bottom, KSCREEN_WIDTH, KSCREEN_HEIGHT - 37 - 64) collectionViewLayout:layout];
        [_collectionView setCollectionViewLayout:layout];
        _collectionView.backgroundColor = KAPP_WHITE_COLOR;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        
        [_collectionView registerClass:[HYGoodsItemCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



@end

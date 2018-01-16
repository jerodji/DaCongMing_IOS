//
//  HYMyCollectShopViewController.m
//  DaCongMing
//
//

#import "HYMyCollectShopViewController.h"
#import "HYMyCollectionShopCell.h"
#import "HYMineNetRequest.h"
#import "HYMyCollectShopModel.h"
#import "HYBrandShopViewController.h"
#import "HYGoodsDetailInfoViewController.h"


@interface HYMyCollectShopViewController ()<UITableViewDelegate,UITableViewDataSource>

/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 没有数据 */
@property (nonatomic,strong) HYNoCollectImgView *noDataView;

@end

@implementation HYMyCollectShopViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    [self requestNetwork];
}

- (void)setupSubviews{
    
    self.title = @"收藏的店铺";
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    [self.view addSubview:self.tableView];
}

- (void)requestNetwork{
    
    [HYMineNetRequest getMyCollectShopWithPageNo:1 ComplectionBlock:^(NSArray *datalist) {
       
        if (datalist.count) {
            
            [self.datalist addObjectsFromArray:datalist];
            [_tableView reloadData];
        }
        else{
            
            [self.tableView removeFromSuperview];
            self.tableView = nil;
            [self.view addSubview:self.noDataView];
        }
        
    }];
}

#pragma mark - method
- (void)cancelCollectShopWithShopID:(NSString *)shopID indexPath:(NSIndexPath *)indexPath{
    
    HYCustomAlert *customAlert = [[HYCustomAlert alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) WithTitle:@"温馨提示" content:@"确定要取消店铺收藏" confirmBlock:^{
        
        [HYGoodsHandle cancelCollectShopWithSellerIDs:shopID ComplectionBlock:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"店铺取消成功"];
                [self.datalist removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
            }
            else{
                
                [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"店铺取消失败"];
                
            }
        }];
    }];
    
    [KEYWINDOW addSubview:customAlert];
    [customAlert showCustomAlert];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCollectionShopCellID = @"myCollectionShopCellID";
    HYMyCollectionShopCell *cell = [tableView dequeueReusableCellWithIdentifier:myCollectionShopCellID];
    if (!cell) {
        cell = [[HYMyCollectionShopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCollectionShopCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *dict = self.datalist[indexPath.row];
    HYMyCollectShopModel *model = [HYMyCollectShopModel modelWithDictionary:dict];
    cell.collectShopModel = model;
    cell.collectionSelect = ^(NSString *productID) {
        
        HYGoodsDetailInfoViewController *detailVC = [[HYGoodsDetailInfoViewController alloc] init];
        detailVC.navigationController.navigationBar.hidden = YES;
        detailVC.goodsID = productID;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    cell.cancelCollect = ^(NSString *shopID) {
        
        [self cancelCollectShopWithShopID:shopID indexPath:indexPath];
    };
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYBrandShopViewController *shopVC = [HYBrandShopViewController new];
    NSDictionary *dict = self.datalist[indexPath.row];
    HYMyCollectShopModel *model = [HYMyCollectShopModel modelWithDictionary:dict];
    shopVC.sellerID = model.seller_id;
    [self.navigationController pushViewController:shopVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 214 * WIDTH_MULTIPLE;
}


#pragma mark - lazyload
- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f4f4f4");
    }
    return _tableView;
}

- (HYNoCollectImgView *)noDataView{
    
    if (!_noDataView) {
        
        _noDataView = [[HYNoCollectImgView alloc] init];
    }
    return _noDataView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

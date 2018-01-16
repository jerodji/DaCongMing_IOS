//
//  HYSortViewController.m
//  DaCongMing
//
//

#import "HYSortViewController.h"
#import "HYGoodsListViewController.h"


#import "HYSortModel.h"
#import "HYSortTableViewCell.h"

@interface HYSortViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *datalist;

@end

@implementation HYSortViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    _datalist = [NSMutableArray array];
    
    [self requestSortData];
    [self setupNav];
}

- (void)setupNav{
    
    self.navigationController.navigationBar.barTintColor = KAPP_NAV_COLOR;
    UIImageView *titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, KSCREEN_WIDTH, 34)];
    titleImgView.image = [UIImage imageNamed:@"sort_title"];
    titleImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImgView;
}

- (void)viewDidLayoutSubviews{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - networkRequest
- (void)requestSortData{
    
    //如果本地有缓存，直接去本地
    if ([HYPlistTools isFileExistWithFileName:KSortListPlist]) {
        
        NSArray *array = [HYPlistTools unarchivewithName:KSortListPlist];
        [_datalist removeAllObjects];
        [_datalist addObjectsFromArray:array];
        [_tableView reloadData];
        return;
    }
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Sort withParameter:nil isShowHUD:YES success:^(id returnData) {
       
        if (returnData) {
            
            if ([[returnData objectForKey:@"code"] integerValue] == 000) {
                
                NSArray *array = [[returnData objectForKey:@"data"] objectForKey:@"dataList"];
                
                [_datalist removeAllObjects];
                for (NSDictionary *dict in array) {
                    
                    HYSortModel *model = [HYSortModel modelWithDictionary:dict];
                    [_datalist addObject:model];
                
                    [_tableView reloadData];
                }
                
                //存入plist
                [HYPlistTools archiveObject:_datalist withName:KSortListPlist];
            }
        }
    }];
}

- (void)refreshDataAction{
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_Sort withParameter:nil isShowHUD:YES success:^(id returnData) {
        
        if (returnData) {
            
            if ([[returnData objectForKey:@"code"] integerValue] == 000) {
                
                NSArray *array = [[returnData objectForKey:@"data"] objectForKey:@"dataList"];
                
                [_datalist removeAllObjects];
                for (NSDictionary *dict in array) {
                    
                    HYSortModel *model = [HYSortModel modelWithDictionary:dict];
                    [_datalist addObject:model];
                    
                    [_tableView reloadData];
                }
                
                //存入plist
                [HYPlistTools archiveObject:_datalist withName:KSortListPlist];
                [_tableView.mj_header endRefreshing];
            }
        }
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"";
    HYSortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HYSortTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = self.datalist[indexPath.row];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYSortModel *model = self.datalist[indexPath.row];
    HYGoodsListViewController *goodsListVC = [[HYGoodsListViewController alloc] init];
    goodsListVC.title = model.type_name;
    goodsListVC.type = model.type_id;
    [self.navigationController pushViewController:goodsListVC animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110 * WIDTH_MULTIPLE;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataAction)];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

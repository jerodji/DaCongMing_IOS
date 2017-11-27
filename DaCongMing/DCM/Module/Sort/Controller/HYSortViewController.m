//
//  HYSortViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64 - 49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

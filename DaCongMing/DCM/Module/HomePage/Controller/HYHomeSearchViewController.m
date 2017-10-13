//
//  HYHomeSearchViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomeSearchViewController.h"
#import "HYSearchTitleView.h"
#import "HYHotSearchView.h"
#import "HYSearchHandle.h"

@interface HYHomeSearchViewController () <HYSearchTextFieldTextChangedDelegate,UITableViewDelegate,UITableViewDataSource>

/** searchTitleView */
@property (nonatomic,strong) HYSearchTitleView *searchTitleView;
/** hotSearchView */
@property (nonatomic,strong) HYHotSearchView *hotSearchView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** 搜索结果 */
@property (nonatomic,strong) NSArray *searchArray;

@end

@implementation HYHomeSearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = KAPP_WHITE_COLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)setupUI{
    
    [self.navigationController.navigationBar addSubview:self.searchTitleView];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.hotSearchView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_searchTitleView removeFromSuperview];
    _searchTitleView = nil;
}

- (void)viewWillLayoutSubviews{
    
    [_hotSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(150 * WIDTH_MULTIPLE));
    }];
}

#pragma mark - searchDelegate
- (void)searchTextFieldTextChanged:(NSString *)text{
    
    [HYSearchHandle searchProductsWithText:text complectionBlock:^(NSArray *datalist) {
       
        if (datalist) {
            
            DLog(@"%@",datalist);
            self.searchArray = datalist;
        }
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 10;
}


#pragma mark - lazyload
- (HYSearchTitleView *)searchTitleView{
    
    if (!_searchTitleView) {
        
        _searchTitleView = [[HYSearchTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        _searchTitleView.delegate = self;
        __weak typeof (self)weakSelf = self;
        _searchTitleView.cancenBlock = ^{
          
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _searchTitleView;
}

- (HYHotSearchView *)hotSearchView{
    
    if (!_hotSearchView) {
        
        _hotSearchView = [HYHotSearchView new];
    }
    return _hotSearchView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end

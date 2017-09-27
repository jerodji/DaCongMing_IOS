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

@interface HYHomeSearchViewController ()

/** searchTitleView */
@property (nonatomic,strong) HYSearchTitleView *searchTitleView;
/** hotSearchView */
@property (nonatomic,strong) HYHotSearchView *hotSearchView;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;

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

#pragma mark - lazyload
- (HYSearchTitleView *)searchTitleView{
    
    if (!_searchTitleView) {
        
        _searchTitleView = [[HYSearchTitleView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end

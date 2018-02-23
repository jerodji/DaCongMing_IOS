//
//  MoreArticleVC.m
//  DaCongMing
//
//  Created by hailin on 2018/2/8.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "MoreArticleVC.h"
#import "JJNatureCell.h"

@interface MoreArticleVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString* token;
    NSInteger pageNo;
}
@property (nonatomic,strong) UITableView * tableview;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation MoreArticleVC

- (void)loadView {
    [super loadView];
    _dataArray = [[NSMutableArray alloc] init];
    token = [HYUserModel sharedInstance].token;
    pageNo = 1;
    [[HTTPManager shareHTTPManager] postDataFromUrl:net_getArticleList withParameter:@{@"token":token,@"pageNo":@(pageNo)} isShowHUD:YES success:^(id returnData) {
        if (![returnData[@"code"] isEqualToString:@"000"]) {
            return ;
        }
        
        NSArray* arr = (NSArray*)returnData[@"data"][@"list"];
        for (int i=0; i<arr.count; i++) {
            NSDictionary* dict = [arr objectAtIndex:i];
            JJNatureModel* model = [JJNatureModel modelFromDict:dict];
            model.jumpUrl = [dict objectForKey:@"url"];
            [_dataArray addObject:model];
        }
        [_tableview reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康资讯";
    
    _tableview = [[UITableView alloc] init];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNAV_HEIGHT);
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchMoreData)];
    [self.view addSubview:_tableview];
}

- (void)fetchMoreData {
    pageNo++;
    [[HTTPManager shareHTTPManager] postDataFromUrl:net_getArticleList withParameter:@{@"token":token,@"pageNo":@(pageNo)} isShowHUD:NO success:^(id returnData) {
        if(!returnData) {
            [_tableview.mj_footer endRefreshing];
            return ;
        }
            
        if (![returnData[@"code"] isEqualToString:@"000"]) {
            [_tableview.mj_footer endRefreshing];
            return ;
        }
        
        NSArray* arr = (NSArray*)returnData[@"data"][@"list"];
        for (int i=0; i<arr.count; i++) {
            NSDictionary* dict = [arr objectAtIndex:i];
            JJNatureModel* model = [JJNatureModel modelFromDict:dict];
            model.jumpUrl = [dict objectForKey:@"url"];
            [_dataArray addObject:model];
        }
        [_tableview.mj_footer endRefreshing];
        [_tableview reloadData];
    }];
}


#pragma mark-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JJNatureModel* model = [_dataArray objectAtIndex:indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellArticleId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellArticleId"];
        cell.backgroundColor = UIColorRGB(233, 233, 233);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell removeAllSubviews];
    JJNatureCell* view = [[JJNatureCell alloc] initWithFrame:CGRectMake(10, 8, KSCREEN_WIDTH-20, HeightNature)];
    [view setModel:model];
    view.layer.shadowColor = [UIColor clearColor].CGColor;
    view.userInteractionEnabled = NO;
    [cell addSubview:view];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 8+HeightNature+7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JJNatureModel* model = [_dataArray objectAtIndex:indexPath.row];
//    NSDictionary* params = @{@"img":model.img,@"title":model.title,@"descriptions":model.descriptions};
//    [DCURLRouter pushURLString:model.jumpUrl query:params animated:YES];
    NSString* url = [NSString stringWithFormat:@"%@?img=%@&title=%@&descriptions=%@",model.jumpUrl,model.img,model.title,model.descriptions];
    [DCURLRouter pushURLString:url animated:YES];
}


@end

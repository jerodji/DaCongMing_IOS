
////
//  JJTableController.m
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJTableController.h"

@interface JJTableController()
{
    NSInteger sortTypeLines;
    CGFloat sortTypeCellHeight;
}
@property (nonatomic, assign) CGRect rect;
@end

@implementation JJTableController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotyUpdateTableView object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _rect = frame;
        self.homeData = [[NSArray alloc] init];
        self.modelArray = [[NSMutableArray alloc] init];
        
        _tableView = [[UITableView alloc] initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setSeparatorColor:[UIColor clearColor]];
        _tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.estimatedRowHeight =0;
        self.tableView.estimatedSectionHeaderHeight =0;
        self.tableView.estimatedSectionFooterHeight =0;
        
        sortTypeLines = 1;
        sortTypeCellHeight = (HeightSortTypeCell+10) * 1;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView:) name:NotyUpdateTableView object:nil];
        
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchData)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchData)];
//        MJRefreshBackNormalFooter* footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchData)];
//        _tableView.mj_footer = footer;
    }
    return self;
}

- (void)updateTableView:(NSNotification*)noty {
//    NSLog(@"zkzkzkzkz");
    NSString* isZK = [noty.userInfo objectForKey:@"isZK"];
    [UIView animateWithDuration:0.5 animations:^{
        if ([isZK isEqualToString:@"1"]) {
            sortTypeCellHeight = (HeightSortTypeCell+10) * sortTypeLines;
        } else {
            sortTypeCellHeight = (HeightSortTypeCell+10) * 1;
        }
        [_tableView reloadData];
    }];
}

#pragma mark - 首页数据

- (void)fetchData {
    
    __weak typeof(self) wkself = self;
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:HomePageAPI withParameter:nil isShowHUD:YES success:^(id returnData) {
        [wkself.tableView.mj_footer endRefreshing];
        //[self.tableView.mj_footer endRefreshingWithNoMoreData];
        if (IsNull(returnData)) {
            return;
        }
        
         NSDictionary* returnDict = (NSDictionary*)returnData;
        if (NotNull(wkself.modelArray)) {
            [self.modelArray removeAllObjects];
        }
        
        if (![returnDict[@"code"] isEqualToString:@"000"])
            return;
        if (IsNull([returnDict objectForKey:@"data"]))
            return;
        
        NSDictionary* data = [returnDict objectForKey:@"data"];
        if (IsNull([data objectForKey:@"homeData"]))
            return;
        _homeData = [data objectForKey:@"homeData"];
        
        for (int index=0; index<_homeData.count; index++)
        {
            NSDictionary* dict = (NSDictionary*)_homeData[index];
            //计算行高
            JJTableModel* model = [[JJTableModel alloc] init];
            model.cellHeight = [wkself heightForItemAtIndex:index];
            
            if (NotNull([dict objectForKey:@"showType"]))
            {
                model.showType = [dict objectForKey:@"showType"];
                if ([model.showType isEqualToString:ShowTypeBanner]) {
                    if (NotNull([dict objectForKey:model.showType])) {
                        model.bannerList = (NSArray*)[dict objectForKey:model.showType];
                    }
                } else if ([model.showType isEqualToString:ShowTypeNewBanner]) {
                    if (NotNull([dict objectForKey:model.showType])) {
                        model.bannerList = (NSArray*)[dict objectForKey:model.showType];
                    }
                    !_typeCB ? : _typeCB(model.bannerList);
                    //self.tableView.frame = CGRectMake(_rect.origin.x, HeightNewBanner, _rect.size.width, _rect.size.height);
                } else {
                    if (NotNull([dict objectForKey:model.showType])) {
                        model.MAP = (NSDictionary*)[dict objectForKey:model.showType];
                    }
                    if (NotNull([model.MAP objectForKey:@"title"])) {
                        model.title = [model.MAP objectForKey:@"title"];
                    }
                    if (NotNull([model.MAP objectForKey:@"smallTitle"])) {
                        model.smallTitle = [model.MAP objectForKey:@"smallTitle"];
                    }
                    if (NotNull([model.MAP objectForKey:@"block"])) {
                        model.block = (NSArray*)[model.MAP objectForKey:@"block"];
                        
                        if ([model.showType isEqualToString:ShowTypeSortType]) {
                            sortTypeLines = ceil(model.block.count/5.0f);
                        }
                    }
                    if (NotNull([model.MAP objectForKey:@"name"])) {
                        model.name = [model.MAP objectForKey:@"name"];
                    }
                    if (NotNull([model.MAP objectForKey:@"type"])) {
                        model.type = [model.MAP objectForKey:@"type"];
                    }
                }
                
                [wkself.modelArray addObject:model];
            }
        }
        
        [wkself.tableView reloadData];
    }];
}

#pragma mark 行高计算
- (CGFloat)heightForItemAtIndex:(NSInteger)index {
    if (IsNull(_homeData)) { return 0; }
    if (index >= _homeData.count) {return 0;}
    
    NSString* showType = [(NSDictionary*)_homeData[index] objectForKey:@"showType"];
    if ([showType isEqualToString:ShowTypeNewBanner]) {return 0;}
    if ([showType isEqualToString:ShowTypeBanner])    {return HeightBanner;}
    if ([showType isEqualToString:ShowTypeSortType])  {
        return TitleViewHeight + sortTypeCellHeight;
    }
    if ([showType isEqualToString:ShowTypeHotSale])   {return TitleViewHeight + HeightHotSale;}
    if ([showType isEqualToString:ShowTypeHotInStore]){return TitleViewHeight + 330*WIDTH_MULTIPLE + 20;}
    if ([showType isEqualToString:ShowTypeForMale])   {return TitleViewHeight + HeightForMale + 10;}
    if ([showType isEqualToString:ShowTypeNature])    {
        NSDictionary* dict = (NSDictionary*)_homeData[index];
        NSString* showTypeValue = [dict objectForKey:@"showType"];
        NSArray* blockList = [[dict objectForKey:showTypeValue] objectForKey:@"block"];
        if (blockList.count>0)
            return TitleViewHeight + (HeightNature+20) * blockList.count;
        else
            return 0;
    }
    if ([showType isEqualToString:ShowTypeTimeReC])   {return TitleViewHeight + HeightTimeReC;}
    if ([showType isEqualToString:ShowTypeBoutique])  {
//        return TitleViewHeight + (HeightBoutique+20) ;
        NSDictionary* dict = (NSDictionary*)_homeData[index];
        NSString* showTypeValue = [dict objectForKey:@"showType"];
        NSArray* blockList = [[dict objectForKey:showTypeValue] objectForKey:@"block"];
        if (blockList.count>0)
            return TitleViewHeight + (HeightBoutique+20) * blockList.count;
        else
            return 0;
    }
    if ([showType isEqualToString:ShowTypeLTC])       {
        return TitleViewHeight + 5 + (KSCREEN_WIDTH-20)*(HeightLTC/356.f) + 20;}
    
    return 0;
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JJTableModel* model = [self.modelArray objectAtIndex:indexPath.row];
    if ([model.showType isEqualToString:ShowTypeSortType]) {
        return TitleViewHeight + sortTypeCellHeight + 10;
    }
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //复用
    NSString* REUSE_ID = [NSString stringWithFormat:@"ItemCellId_%ld",indexPath.row];
    JJTableCell * cell =[tableView dequeueReusableCellWithIdentifier:REUSE_ID];
    if (!cell) {
        cell = [[JJTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //去掉点击效果
        JJTableModel* model = [self.modelArray objectAtIndex:indexPath.row];
        [cell setModel:model];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollDelegate && [_scrollDelegate respondsToSelector:@selector(tableScrollDidScroll:)]) {
        [_scrollDelegate tableScrollDidScroll:scrollView];
    }
}

// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动，只执行一次）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_scrollDelegate && [_scrollDelegate respondsToSelector:@selector(tableScrollWillBeginDragging:)]) {
        [_scrollDelegate tableScrollWillBeginDragging:scrollView];
    }
}

// 滑动scrollView，并且手指将要离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (_scrollDelegate && [_scrollDelegate respondsToSelector:@selector(tableScrollWillEndDragging:withVelocity:targetContentOffset:)]) {
        [_scrollDelegate tableScrollWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_scrollDelegate && [_scrollDelegate respondsToSelector:@selector(tableScrollDidEndDragging:)]) {
        [_scrollDelegate tableScrollDidEndDragging:scrollView];
    }
}

@end

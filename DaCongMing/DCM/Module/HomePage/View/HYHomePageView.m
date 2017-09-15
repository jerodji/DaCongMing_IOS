//
//  HYHomePageView.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYHomePageView.h"

#import "HYHomeImgCell.h"
#import "HYHomeTitleScrollCell.h"
#import "HYHomeImgScrollCell.h"
#import "HYHomeCollectionCell.h"
#import "HYHomeBannerCell.h"
#import "HYHomeDoodsCell.h"

@interface HYHomePageView() <UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

/** headerView */
@property (nonatomic,strong) SDCycleScrollView *headerView;

@end

@implementation HYHomePageView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame style:UITableViewStyleGrouped]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.headerView;
    }
    return self;
}

- (void)layoutSubviews{
    
    _headerView.imageURLStringsGroup = _model.banners;

}

#pragma mark - lazyload
- (UIView *)headerView{
    
    if (!_headerView) {
        
        //轮播图
        _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"banner.jpg"]];
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _headerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _headerView.autoScrollTimeInterval = 2;
        _headerView.pageDotColor = KAPP_THEME_COLOR;
        _headerView.imageURLStringsGroup = _model.banners;
        _headerView.autoScroll = YES;
        _headerView.infiniteLoop = YES;
        _headerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _headerView;
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSLog(@"xxx");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"ggg");
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //纯图片的cell
        
        static NSString *cellID = @"HYImgCell";
        HYHomeImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HYHomeImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.imgUrl = _model.disCount.image_url;
        return cell;
    }
    else if (indexPath.row == 1){
    
        static NSString *cellID = @"HYTitle";
        HYHomeImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HYHomeImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.imgUrl = _model.disCount.image_url;
        return cell;
    }
    else{
        static NSString *cellID = @"";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
    
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 150;
    }
    return 100;
}


@end

//
//  JJTableController.h
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JJTableCell.h"


@protocol JJTableScrollDelegate<NSObject>
@optional
- (void)tableScrollWillBeginDragging:(UIScrollView *)scrollView;
- (void)tableScrollDidScroll:(UIScrollView *)scrollView;
- (void)tableScrollWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
- (void)tableScrollDidEndDragging:(UIScrollView *)scrollView;
@end


typedef void (^SHOWTYPEBLK)(NSArray* NewBannerList);


@interface JJTableController : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * homeData;
@property (nonatomic, strong) NSMutableArray<JJTableModel*>* modelArray;
@property (nonatomic, strong) SHOWTYPEBLK typeCB;
@property (nonatomic,weak) id<JJTableScrollDelegate> scrollDelegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)fetchData;
@end

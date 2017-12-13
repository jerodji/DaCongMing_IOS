//
//  HYPayParterCostViewController.m
//  DaCongMing
//
//  Created by Jack on 2017/12/12.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYPayParterCostViewController.h"
#import "HYRecommendPayItemCell.h"
#import "HYRecommendIntroCell.h"
#import "HYRecommendPayModeCell.h"
#import "HYPayBottomView.h"
#import "HYParterPayModel.h"
#import "HYParterPayResultVC.h"

@interface HYPayParterCostViewController ()

/** bottomView */
@property (nonatomic,strong) HYPayBottomView *bottomView;
/** 上一个选择的btn */
@property (nonatomic,strong) UIButton *previousBtn;
@property (nonatomic,strong) HYParterPayModel *model;

@end

@implementation HYPayParterCostViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"支付";
    [KEYWINDOW addSubview:self.bottomView];
    _model = [HYParterPayModel new];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count <= 1) {
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
        self.navigationItem.leftBarButtonItem = cancelItem;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_bottomView removeFromSuperview];
    _bottomView = nil;
}

#pragma mark - action
- (void)payButtonAction:(UIButton *)sender{
    
    _previousBtn.selected = NO;
    sender.selected = YES;
    _previousBtn = sender;
    
    _model.payMode = sender.tag - 900;
    
}

- (void)cancelAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 2) {
        
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 33 * WIDTH_MULTIPLE;
    }
    else if (indexPath.section == 1){
        
        return 220 * WIDTH_MULTIPLE;
    }
    else{
        return 44 * WIDTH_MULTIPLE;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *payItemCellID = @"payItemCellID";
        HYRecommendPayItemCell *cell = [tableView dequeueReusableCellWithIdentifier:payItemCellID];
        if (!cell) {
            cell = [[HYRecommendPayItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payItemCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.section == 1){
        
        static NSString *recommendIntroCellID = @"recommendIntroCellID";
        HYRecommendIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendIntroCellID];
        if (!cell) {
            cell = [[HYRecommendIntroCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendIntroCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.section == 2){
        
        static NSString *payModeCellID = @"payModeCellID";
        HYRecommendPayModeCell *cell = [tableView dequeueReusableCellWithIdentifier:payModeCellID];
        if (!cell) {
            cell = [[HYRecommendPayModeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payModeCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.indexPath = indexPath;
        cell.selectBtn.tag = indexPath.row + 900;
        [cell.selectBtn addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        if (indexPath.row == 0) {
            
            [cell setIConImage:@"order_alipay" andTitle:@"支付宝"];
            cell.selectBtn.selected = YES;
            self.previousBtn = cell.selectBtn;
            return cell;
        }
        else{
            
            [cell setIConImage:@"order_weChat" andTitle:@"微信"];
            return cell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        HYRecommendPayModeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self payButtonAction:cell.selectBtn];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    view.backgroundColor = KCOLOR(@"f4f4f4");
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 * WIDTH_MULTIPLE;
}

#pragma mark - lazyload
- (HYPayBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[HYPayBottomView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - 50 * WIDTH_MULTIPLE, KSCREEN_WIDTH, 50 * WIDTH_MULTIPLE)];
        
        __weak typeof (self)weakSelf = self;
        _bottomView.payBlock = ^{
          
            [weakSelf.navigationController pushViewController:[HYParterPayResultVC new] animated:YES];
        };
    }
    return _bottomView;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

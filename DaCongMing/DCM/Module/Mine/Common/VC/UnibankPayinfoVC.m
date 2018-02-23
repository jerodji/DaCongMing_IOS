//
//  UnibankPayinfoVC.m
//  DaCongMing
//
//  Created by hailin on 2018/2/2.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "UnibankPayinfoVC.h"
#import "UniPayInfoCell.h"
#import "ShowUnipayInfoView.h"
#import "HYPayHandle.h"
#import "FinishCommitVC.h"

@interface UnibankPayinfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation UnibankPayinfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡支付";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNAV_HEIGHT - (70 + KSafeAreaBottom_Height)) ];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    /**
     * iOS11默认开启Self-Sizing，关闭Self-Sizing,否则iOS11以上header高度无效
     */
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
    
    UIButton* reFillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reFillBtn.frame = CGRectMake(15, _tableView.bottom+10, (KSCREEN_WIDTH-45)/2, 50);
    reFillBtn.userInteractionEnabled = YES;
    [reFillBtn setTitle:@"重新填写" forState:UIControlStateNormal];
    [reFillBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reFillBtn setBackgroundColor:UIColorRGB(179, 179, 179)];
    [reFillBtn addTarget:self action:@selector(reFillAction) forControlEvents:UIControlEventTouchUpInside];
    reFillBtn.layer.cornerRadius = 5;
    [self.view addSubview:reFillBtn];
    
    
    UIButton* finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(15+reFillBtn.bounds.size.width+15, _tableView.bottom+10, (KSCREEN_WIDTH-45)/2, 50);
    finishBtn.userInteractionEnabled = YES;
    [finishBtn setTitle:@"我已转账" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn setBackgroundColor:UIColorRGB(56, 173, 152)];
    [finishBtn addTarget:self action:@selector(iFinishedPayAction) forControlEvents:UIControlEventTouchUpInside];
    finishBtn.layer.cornerRadius = 5;
    [self.view addSubview:finishBtn];
}

- (void)reFillAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)iFinishedPayAction {
    [HYPayHandle unipaymentOfflineWithBank:self.bank acount:self.acount name:self.name pbone:self.phone complectionBlock:^(BOOL suc) {
        if (suc) {
            //NSLog(@"提交成功");
            FinishCommitVC* comitVC = [FinishCommitVC new];
            [self.navigationController pushViewController:comitVC animated:YES];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        static NSString* infoId = @"bankPayinfoID";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:infoId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UniPayInfoCell* view = [UniPayInfoCell loadXIB];
            view.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height-40);
            [cell.contentView addSubview:view];
            
            UIView* line = [[UIView alloc] init];
            line.frame = CGRectMake(15, 130+3, _tableView.bounds.size.width-30, 1);
            line.backgroundColor = UIColorRGB(229,229,229);
            [cell.contentView addSubview:line];
            
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(15, line.bottom, line.width, 36)];
            lab.text = self.time;
            lab.font = [UIFont systemFontOfSize:13];
            lab.textColor = UIColorRGB(39, 39, 39);
            lab.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:lab];
        }
        return cell;
    }
    if (indexPath.section==1) {
        static NSString* infoId = @"showPayinfoID";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:infoId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            ShowUnipayInfoView* view = [ShowUnipayInfoView loadXIB];
            view.frame = cell.bounds;
            view.bankLabel.text = self.bank;
            view.acountLabel.text = self.acount;
            view.nameLabel.text = self.name;
            view.phoneLabel.text = self.phone;
            [cell.contentView addSubview:view];
        }
        return cell;
    }
    
    static NSString* infoId = @"ff";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:infoId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = UIColorRGB(229, 229, 229);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 10;
    } else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 130+40;
    }
    if (indexPath.section==1) {
        return 210;
    }
    return 1;
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

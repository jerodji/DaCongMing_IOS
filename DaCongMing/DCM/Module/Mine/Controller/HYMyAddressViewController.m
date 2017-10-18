//
//  HYMyAddressViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyAddressViewController.h"
#import "HYNoAddressView.h"
#import "HYRequestOrderHandle.h"
#import "HYMyAddressModel.h"
#import "HYAddressTableViewCell.h"
#import "HYAddAddressViewController.h"


@interface HYMyAddressViewController () <UITableViewDelegate,UITableViewDataSource,HYAddressBtnActionDelegate>

/** 添加地址 */
@property (nonatomic,strong) UIButton *addNewAddress;
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** noAddressView */
@property (nonatomic,strong) HYNoAddressView *noAddressView;

/** 默认地址 */
@property (nonatomic,strong) HYMyAddressModel *defaultModel;


@end

@implementation HYMyAddressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestData];

}

- (void)setupSubviews{
    
    if (self.isJump) {
        
        self.title = @"选择地址";
    }
    else{
        
        self.title = @"我的地址";
    }
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    [self.view addSubview:self.addNewAddress];
}

- (void)viewDidLayoutSubviews{
    
    [_addNewAddress mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.height.equalTo(@(45 * WIDTH_MULTIPLE));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_addNewAddress.mas_bottom);
    }];
    
    [_noAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_addNewAddress.mas_bottom);
    }];
}

- (void)requestData{
    
    [self.datalist removeAllObjects];
    [HYRequestOrderHandle requestReceivedAddressComplectionBlock:^(NSArray *datalist) {
        
        [_noAddressView removeFromSuperview];
        _noAddressView = nil;
        
        
        for (NSDictionary *dict in datalist) {
            
            HYMyAddressModel *model = [HYMyAddressModel modelWithDictionary:dict];
            if ([model.isdefault integerValue] == 1) {
                
                self.defaultModel = model;
            }
            [_datalist addObject:model];
        }
        
        [self.view addSubview:self.tableView];
        [_tableView reloadData];
        
    } noDataBlock:^{
       
        [_tableView removeFromSuperview];
        _tableView = nil;
        
        [self.view addSubview:self.noAddressView];
        
    }];
}

#pragma mark - action
- (void)addNewAddressAction{
    
    HYAddAddressViewController *addAddressVC = [HYAddAddressViewController new];
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

- (void)setDefaultAddressWithIndexPath:(NSIndexPath *)indexPath{
    
    HYMyAddressModel *addressModel = _datalist[indexPath.section];
    [HYRequestOrderHandle setDefaultReceivedAddress:addressModel.address_id oldAddressID:self.defaultModel.address_id ComplectionBlock:^(BOOL isSuccess) {
       
        if (isSuccess) {
            
            self.defaultModel = addressModel;
            [self requestData];
        }
        else{
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"删除收货地址失败"];
        }
    }];
}

- (void)editAddressWithIndexPath:(NSIndexPath *)indexPath{
    
    HYMyAddressModel *addressModel = _datalist[indexPath.section];
    HYAddAddressViewController *addAddressVC = [HYAddAddressViewController new];
    [self.navigationController pushViewController:addAddressVC animated:YES];
    addAddressVC.addressModel = addressModel;
}

- (void)deleteAddressWithIndexPath:(NSIndexPath *)indexPath{
    
    HYMyAddressModel *addressModel = _datalist[indexPath.section];
    [HYRequestOrderHandle deleteReceivedAddress:addressModel.address_id ComplectionBlock:^(BOOL isSuccess) {
       
        if (isSuccess) {
            
            [self requestData];
        }
        else{
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"删除收货地址失败"];
        }
    }];
}

#pragma mark - cellDelegate
- (void)addressBtnAcitonWithFlag:(NSInteger)flag indexPath:(NSIndexPath *)indexPath{
    
    switch (flag) {
        case 0:
            
            [self setDefaultAddressWithIndexPath:indexPath];
            break;
        case 1:
            [self editAddressWithIndexPath:indexPath];
            break;
        case 2:
            [self deleteAddressWithIndexPath:indexPath];
            break;
        default:
            break;
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datalist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"HYAddressCellID";
    HYAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HYAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.addressModel = self.datalist[indexPath.section];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HYMyAddressModel *addressModel = self.datalist[indexPath.section];
    if (_isJump) {
        
        self.selectAddBlock(addressModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 * WIDTH_MULTIPLE;
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
- (UIButton *)addNewAddress{
    
    if (!_addNewAddress) {
        
        _addNewAddress = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addNewAddress setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_addNewAddress setTitleColor:KAPP_272727_COLOR forState:UIControlStateNormal];
        _addNewAddress.backgroundColor = KAPP_WHITE_COLOR;
        _addNewAddress.titleLabel.font = KFitFont(18);
        [_addNewAddress addTarget:self action:@selector(addNewAddressAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addNewAddress;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _tableView;
}

- (HYNoAddressView *)noAddressView{
    
    if (!_noAddressView) {
        
        _noAddressView = [HYNoAddressView new];
    }
    return _noAddressView;
}

- (NSMutableArray *)datalist{
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  HYAddAddressViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/28.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYAddAddressViewController.h"
#import "HYTextFieldTableViewCell.h"
#import "AreaView.h"
#import "HYProvinceModel.h"
#import "HYRequestOrderHandle.h"

@interface HYAddAddressViewController () <UITableViewDelegate,UITableViewDataSource,AreaSelectDelegate,HYTextFieldCellDelegate>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** datalist */
@property (nonatomic,strong) NSMutableArray *datalist;
/** dataSourceArray */
@property (nonatomic,strong) NSMutableArray *dataSourceArray;
/** 选择城市 */
@property (nonatomic,strong) AreaView *areaView;

@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;

@end

@implementation HYAddAddressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupData];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"添加收货地址";
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setupData{
    
    self.datalist = [NSMutableArray arrayWithObjects:@"姓名:",@"手机号码:",@"所在地区:",@"详细地址:", nil];
    self.dataSourceArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",nil];
    
    [self requestCityData];
    
}

- (void)requestCityData{
    
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_CityData withParameter:nil isShowHUD:NO success:^(id returnData) {
       
        if (returnData) {
            
            NSArray *dataInfo = [returnData objectForKey:@"dataInfo"];
            if (dataInfo) {
                
                for (NSDictionary *dict in dataInfo) {
                    
                    HYProvinceModel *model = [HYProvinceModel modelWithDictionary:dict];
                    [self.areaView.provinceArray addObject:model];
                }
            }
        }
    }];
}

#pragma mark - action
- (void)saveAction{
    
    if (![_dataSourceArray[0] isNotBlank]) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请填写收货人姓名"];
        return;
    }
    
    if (![_dataSourceArray[1] isNotBlank]) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请填写收货人手机号码"];
        return;
    }
    
    if ([_dataSourceArray[1] length] != 11) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请正确填写收货人手机号码"];
        return;
    }
    
    if (![_dataSourceArray[2] isNotBlank]) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请选择省市县"];
        return;
    }
    
    if (![_dataSourceArray[3] isNotBlank]) {
        
        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"请填写详细收货地址"];
        return;
    }
    
    [self uploadAddress];
}

- (void)uploadAddress{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:_dataSourceArray[0] forKey:@"receiver"];
    [dict setValue:_dataSourceArray[1] forKey:@"phoneNum"];
    [dict setValue:_dataSourceArray[3] forKey:@"address"];
    [dict setValue:_province forKey:@"province"];
    [dict setValue:_city forKey:@"city"];
    [dict setValue:_area forKey:@"area"];
    [dict setValue:@(0) forKey:@"isdefault"];
    [HYRequestOrderHandle addReceivedAddress:dict ComplectionBlock:^(BOOL isSuccess) {
       
        if (isSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
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
    
    static NSString *cellID = @"HYTextFieldTableViewCell";
    HYTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HYTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.title = _datalist[indexPath.row];
    cell.textField.text = _dataSourceArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    if (indexPath.row == 1) {
        
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.row == 2) {
        cell.textField.userInteractionEnabled = NO;
    }
    
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.view endEditing:YES];
    
    if (indexPath.row == 2) {
        
        [KEYWINDOW addSubview:self.areaView];
        [_areaView showAreaView];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 * WIDTH_MULTIPLE;
}

#pragma mark - areaSelectDelegate
- (void)getSelectAddressProvince:(NSString *)province city:(NSString *)city area:(NSString *)area{
    
    self.province = province;
    self.city = city;
    self.area = area;
    NSString *str = [NSString stringWithFormat:@"%@-%@-%@",province,city,area];
    [self.dataSourceArray replaceObjectAtIndex:2 withObject:str];
    [_tableView reloadData];
}

#pragma mark - textFieldInputDelegate
- (void)textFieldCellInput:(HYTextFieldTableViewCell *)cell{
    
    NSString *inputStr = cell.textField.text;
    DLog(@"%@",inputStr);
    
    if (cell.indexPath.row == 1) {
        
        if (cell.textField.text.length >= 11) {
            
            cell.textField.text = [cell.textField.text substringToIndex:11];
        }
      
    }
    
    [_dataSourceArray replaceObjectAtIndex:cell.indexPath.row withObject:cell.textField.text];
}

#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f4f4f4");
    }
    return _tableView;
}

- (AreaView *)areaView{
    
    if (!_areaView) {
        
        _areaView = [[AreaView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        _areaView.delegate = self;
    }
    return _areaView;
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

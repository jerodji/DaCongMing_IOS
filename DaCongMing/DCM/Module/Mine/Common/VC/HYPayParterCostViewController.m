//
//  HYPayParterCostViewController.m
//  DaCongMing
//
//

#import "HYPayParterCostViewController.h"
#import "HYRecommendPayItemCell.h"
#import "HYRecommendIntroCell.h"
#import "HYRecommendPayModeCell.h"
#import "HYPayBottomView.h"
#import "HYParterPayModel.h"
#import "HYParterPayResultVC.h"
#import "HYCreateOrder.h"
#import "HYCreateOrderDatalist.h"
#import "HYPayHandle.h"
#import "HYAlipayManager.h"
#import "HYWeChatPayManager.h"
#import "PayModeView.h"
#import "UniPayInfoCell.h"
#import "FillUnipayInfoView.h"
#import "UnibankPayinfoVC.h"

@interface HYPayParterCostViewController ()

/** bottomView */
@property (nonatomic,strong) HYPayBottomView *bottomView;
/** 上一个选择的btn */
@property (nonatomic,strong) UIButton *previousBtn;
@property (nonatomic,strong) HYParterPayModel *model;
@property (nonatomic,strong) HYCreateOrder *orderModel;
@property (nonatomic,strong) HYCreateOrderDatalist *createOrderDatalist;
/** 支付金额 */
@property (nonatomic,strong) NSString *payAmount;
@property (nonatomic,copy) NSString * unit;
@property (nonatomic,copy) NSString * time;

@property (nonatomic,strong) PayModeView * payModeView;
@property (nonatomic,strong) NSMutableArray * uniInfoArray;

@end

@implementation HYPayParterCostViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"支付";
//    [self requestData];
    
    
    _model = [HYParterPayModel new];
    [self requestData];
    
    _uniInfoArray = [[NSMutableArray alloc] init];
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count <= 1) {
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
        self.navigationItem.leftBarButtonItem = cancelItem;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_bottomView) {
        [KEYWINDOW addSubview:self.bottomView];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _bottomView.y = KSCREEN_HEIGHT - 50 * WIDTH_MULTIPLE - KSafeAreaBottom_Height;
        }];
        [self bottomViewName];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect orgFrame = self.tableView.frame;
    CGRect rect = CGRectMake(0, orgFrame.origin.y, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNAV_HEIGHT- 50*WIDTH_MULTIPLE - KSafeAreaBottom_Height);
    self.tableView.frame = rect;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

    [UIView animateWithDuration:0.5 animations:^{
        if (_bottomView) {
            _bottomView.y = KSCREEN_HEIGHT;
        }
    }];
}

- (void)requestData{
    
    [HYUserHandle getParterRecommendPayOrderComplectionBlock:^(HYCreateOrder *order) {
        
        self.orderModel = order;
        NSDictionary *dict = order.dataList[0];
        self.createOrderDatalist = [HYCreateOrderDatalist modelWithDictionary:dict];
        self.payAmount = self.orderModel.summary_price;
        self.bottomView.payAmount = self.payAmount;
        
        NSString* level = [[[dict objectForKey:@"orderDtls"] objectAtIndex:0] objectForKey:@"unit"];
        self.unit = level;
        
        [self.tableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationMiddle];
    }];
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

#pragma mark - 微信支付通知
- (void)weChatPaySuccess:(NSNotification *)notification{
    
    if ([notification.object isEqualToString:@"YES"]) {
        
        HYParterPayResultVC *resultVC = [HYParterPayResultVC new];
        [self.navigationController pushViewController:resultVC animated:YES];
        resultVC.isSuccess = YES;

    }
    else{
        
        HYParterPayResultVC *resultVC = [HYParterPayResultVC new];
        [self.navigationController pushViewController:resultVC animated:YES];
        resultVC.isSuccess = NO;

    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3 + _uniInfoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    if (section == 2) {
//
//        return 2;
//    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 0.1;
//        return 33 * WIDTH_MULTIPLE;
    }
    if (indexPath.section == 1){
        return 305 * WIDTH_MULTIPLE; //支付方式
    }
    if (indexPath.section == 2) {
        return 160  * WIDTH_MULTIPLE;
    }
    if (indexPath.section == 3) {
        return 45; //预填信息title
    }
    if (indexPath.section==4) {
        return 183; //填写信息
    }
    if (indexPath.section==5) {
        return 130; //转账至大聪明
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==5) {
        return 25 * WIDTH_MULTIPLE;
    }
    return 10 * WIDTH_MULTIPLE;
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
    if (indexPath.section == 1){
        
        static NSString *recommendIntroCellID = @"recommendIntroCellID";
        HYRecommendIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendIntroCellID];
        if (!cell) {
            cell = [[HYRecommendIntroCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommendIntroCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.unit = self.unit;
        cell.payAmount = self.payAmount;
        self.time = cell.time;
        return cell;
    }
    if (indexPath.section == 2){
        
        static NSString *payModeCellID = @"payModeCellID";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:payModeCellID ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payModeCellID];
            
            UILabel* tit = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.frame.size.width-40, 30)];
            tit.text = @"支付方式：";
            tit.font = [UIFont systemFontOfSize:14];
            tit.textColor = UIColorRGB(39, 39, 39);
            tit.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:tit];
            
            _payModeView = [[PayModeView alloc] initWithFrame:CGRectMake(0, 33, tableView.frame.size.width, 110)];
            [cell.contentView addSubview:_payModeView];
            
            __weak typeof(self) wksef = self;
            _payModeView.actionCB = ^(PayMode mode) {
                if (_payModeView.paymode==PayModeWeChat)
                {
                    wksef.model.payMode = PayModeWeChat;
                    [wksef bottomViewName];
                    
                    if (wksef.uniInfoArray.count>0){
                        //[wksef.tableView reloadData]; //直接reload视觉体验很差
                        //一定先remove数据,不然crash
                        [wksef.uniInfoArray removeAllObjects];
                        NSIndexSet *sections = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(3, 3)];
                        [wksef.tableView deleteSections:sections withRowAnimation:UITableViewRowAnimationTop];
                    }
                }
                
                if (_payModeView.paymode == PayModeAliPay)
                {
                    wksef.model.payMode = PayModeAliPay;
                    [wksef bottomViewName];
                    //[wksef.tableView reloadData];
                    
                    if (wksef.uniInfoArray.count > 0){
                        //一定先remove数据,不然crash
                        [wksef.uniInfoArray removeAllObjects];
                        NSIndexSet * sections = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(3, 3)];
                        [wksef.tableView deleteSections:sections withRowAnimation:UITableViewRowAnimationTop];
                    }
                }
                
                if (_payModeView.paymode == PayModeUniPay)
                {
                    wksef.model.payMode = PayModeUniPay;
                    
                    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 45)];
                    lab.text = @"预填付款信息";
                    lab.font = [UIFont systemFontOfSize:15];
                    lab.textColor = UIColorRGB(39, 39, 39);
                    lab.textAlignment = NSTextAlignmentCenter;
                    
                    FillUnipayInfoView * view1 = [FillUnipayInfoView loadXIB];
                    view1.infoListCB = ^(NSMutableArray *array) {
                        NSString* bank   = [array objectAtIndex:0];
                        NSString* acount = [array objectAtIndex:1];
                        NSString* name   = [array objectAtIndex:2];
                        NSString* phone  = [array objectAtIndex:3];
                        wksef.bottomView.bank   = bank;
                        wksef.bottomView.acount = acount;
                        wksef.bottomView.name   = name;
                        wksef.bottomView.phone  = phone;
                    };
                    
                    UniPayInfoCell* view2 = [UniPayInfoCell loadXIB];
//                    [[UniPayInfoCell alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 130)];
//                    view2.frame = CGRectMake(0, 0, KSCREEN_WIDTH, cell.bounds.size.height);
                    [wksef.uniInfoArray addObject:lab];
                    [wksef.uniInfoArray addObject:view1];
                    [wksef.uniInfoArray addObject:view2];
                    
                    [wksef.tableView reloadData];
                    [wksef bottomViewName];
                }
            };
            
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //去掉点击效果
        return cell;
//        HYRecommendPayModeCell *cell = [tableView dequeueReusableCellWithIdentifier:payModeCellID];
//        if (!cell) {
//            cell = [[HYRecommendPayModeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payModeCellID];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        cell.indexPath = indexPath;
//        cell.selectBtn.tag = indexPath.row + 900;
//        [cell.selectBtn addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//
//        if (indexPath.row == 0) {
//
//            [cell setIConImage:@"order_alipay" andTitle:@"支付宝"];
//            cell.selectBtn.selected = YES;
//            self.previousBtn = cell.selectBtn;
//            return cell;
//        }
//        else{
//
//            [cell setIConImage:@"order_weChat" andTitle:@"微信"];
//            return cell;
//        }
    }
    //填写付款信息
    if (indexPath.section==3) {
        static NSString *defID = @"uniPayTitle";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //去掉点击效果
            UILabel* lab = [_uniInfoArray objectAtIndex:0];
            lab.frame = CGRectMake(0, 0, KSCREEN_WIDTH, cell.bounds.size.height);
            [cell.contentView addSubview:lab];
        }
        return cell;
    }
    if (indexPath.section==4) {
        static NSString* fillID = @"fillinfoid";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:fillID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fillID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //去掉点击效果
            FillUnipayInfoView* view1 = [_uniInfoArray objectAtIndex:1];
            view1.frame = CGRectMake(0, 0, KSCREEN_WIDTH, cell.bounds.size.height);
            [cell addSubview:view1];
        }
        return cell;
    }
    if (indexPath.section==5) {
        static NSString* uniPayInfoID = @"uniPayInfoID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:uniPayInfoID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniPayInfoID];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //去掉点击效果
            UIView* titleLab = [_uniInfoArray objectAtIndex:2];
            titleLab.frame = cell.bounds;//CGRectMake(0, 0, KSCREEN_WIDTH, cell.bounds.size.height);
            [cell.contentView addSubview:titleLab];
        }
        return cell;
    }
    
    static NSString *defID = @"def";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 2) {
////        HYRecommendPayModeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
////        [self payButtonAction:cell.selectBtn];
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10 * WIDTH_MULTIPLE)];
    view.backgroundColor = KCOLOR(@"f4f4f4");
    return view;
}

#pragma mark - lazyload

- (void)bottomViewName {
    if (!_bottomView) {
        return;
    }
    if (self.model.payMode==PayModeUniPay) {
        [_bottomView.payBtn setTitle:@"确认" forState:UIControlStateNormal];
    } else {
        [_bottomView.payBtn setTitle:@"支付" forState:UIControlStateNormal];
    }
}

- (HYPayBottomView *)bottomView{
    
    
    if (!_bottomView) {
        
        _bottomView = [[HYPayBottomView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT  - 50 * WIDTH_MULTIPLE - KSafeAreaBottom_Height, KSCREEN_WIDTH, 50 * WIDTH_MULTIPLE + KSafeAreaBottom_Height)];
        __weak typeof (self)weakSelf = self;
        _bottomView.payAmount = weakSelf.payAmount;
        _bottomView.payBlock = ^{
            
            if (weakSelf.orderModel) {
                
                if (self.model.payMode == 0) {
                    
                    [HYPayHandle alipayWithOrderID:weakSelf.createOrderDatalist.sorder_id coupon_guid:nil buyerMessage:nil complectionBlock:^(NSString *sign) {
                        
                        [HYAlipayManager alipayWithOrderString:sign success:^{
                            
                            HYParterPayResultVC *resultVC = [HYParterPayResultVC new];
                            [weakSelf.navigationController pushViewController:resultVC animated:YES];
                            resultVC.isSuccess = YES;

                        } failed:^{
                            
                            HYParterPayResultVC *resultVC = [HYParterPayResultVC new];
                            [weakSelf.navigationController pushViewController:resultVC animated:YES];
                            resultVC.isSuccess = NO;

                        }];
                    }];
                }
                else if (self.model.payMode == PayModeWeChat) {
                    
                    if (![WXApi isWXAppInstalled]) {
                        
                        [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"please install WeChat"];
                        return;
                    }
                    
                    [HYPayHandle weChatPayWithOrder:weakSelf.createOrderDatalist.sorder_id coupon_guid:nil buyerMessage:nil complectionBlock:^(HYWeChatPayModel *weChatPayModel) {
                        
                        [HYWeChatPayManager wechatPayWith:weChatPayModel];
                        
                        [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(weChatPaySuccess:) name:KWeChatPaySuccessNotification object:nil];
                    }];
                }
                else {
                    
                    if (NotNull(weakSelf.bottomView.bank) && NotNull(weakSelf.bottomView.acount) && NotNull(weakSelf.bottomView.name) && NotNull(weakSelf.bottomView.phone) && NotFullSpace(weakSelf.bottomView.bank) && NotFullSpace(weakSelf.bottomView.acount) && NotFullSpace(weakSelf.bottomView.name) && NotFullSpace(weakSelf.bottomView.phone))
                    {
//                        [HYPayHandle unipaymentOfflineWithBank:weakSelf.bottomView.bank acount:weakSelf.bottomView.acount name:weakSelf.bottomView.name pbone:weakSelf.bottomView.phone complectionBlock:^(BOOL suc) {
//                            if (suc) {
                                UnibankPayinfoVC* infoVC = [UnibankPayinfoVC new];
                                infoVC.bank = weakSelf.bottomView.bank;
                                infoVC.acount = weakSelf.bottomView.acount;
                                infoVC.name = weakSelf.bottomView.name;
                                infoVC.phone = weakSelf.bottomView.phone;
                                infoVC.time = weakSelf.time;
                                [weakSelf.navigationController pushViewController:infoVC animated:YES];
//                            }
//                        }];
                    } else {
                        [JJAlert showAlertWithVC:weakSelf message:@"请填写完整的信息" cancleAction:^{
                            
                        } sureAction:^{
                            
                        }];

                    }
                    
                    
                }
            }
          
            
        };
    }
    return _bottomView;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

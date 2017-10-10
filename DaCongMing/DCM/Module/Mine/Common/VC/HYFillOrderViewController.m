//
//  HYFillOrderViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/22.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYFillOrderViewController.h"

#import "HYReceiveAddressTableViewCell.h"
#import "HYGoodsPostageTableViewCell.h"
#import "HYDiscountTableViewCell.h"
#import "HYGoodsPayTableViewCell.h"

#import "HYCreateOrder.h"
#import "HYCreateOrderDatalist.h"

#import "HYPayHandle.h"
#import "HYAlipayManager.h"
#import "HYWeChatPayManager.h"

#import "HYPayResultViewController.h"
#import "HYMyAddressViewController.h"

@interface HYFillOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;

/** orderMode */
@property (nonatomic,strong) HYCreateOrder *orderModel;
/** orderMode */
@property (nonatomic,strong) HYCreateOrderDatalist *createOrderDatalist;
/** payMoneyLabel */
@property (nonatomic,strong) UILabel *payMoneyLabel;
/** 确认 */
@property (nonatomic,strong) UIButton *confirmBtn;

/** payMode */
@property (nonatomic,assign) NSInteger payMode;

@end

@implementation HYFillOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"填写订单";
    [self setupSubviews];
    [self setupMasonryLayout];
    [self requestData];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.payMoneyLabel];
    [self.view addSubview:self.confirmBtn];
}

- (void)setupMasonryLayout{
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-10 * WIDTH_MULTIPLE);
        make.width.equalTo(@(90));
        make.height.equalTo(@(40));
        make.bottom.equalTo(self.view).offset(-10);
    }];
    
    [_payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 * WIDTH_MULTIPLE);
        make.height.equalTo(@(60));
        make.bottom.equalTo(self.view);
        make.right.equalTo(_confirmBtn.mas_left);
    }];
}

- (void)requestData{
    
    [HYGoodsHandle createOrderWithGuid:nil itemID:_goodsDetailModel.item_id count:_buyCount sellerID:_goodsDetailModel.item_of_seller andUnit:_specifical complectionBlock:^(HYCreateOrder *order) {
        
        self.orderModel = order;
        NSDictionary *dict = order.dataList[0];
        self.createOrderDatalist = [HYCreateOrderDatalist modelWithDictionary:dict];
        [_tableView reloadData];
    }];
}

- (void)setOrderModel:(HYCreateOrder *)orderModel{
    
    _orderModel = orderModel;
    NSString *str = [NSString stringWithFormat:@"您需要支付: %@ ",_orderModel.summary_price]; 
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName : KAPP_PRICE_COLOR} range:NSMakeRange(6, str.length - 6)];
    _payMoneyLabel.attributedText = attributeStr;
}

#pragma mark - action
- (void)confirmBtnAction{
    
    if (self.payMode == 0) {
        
        [HYPayHandle alipayWithOrderID:self.createOrderDatalist.sorder_id coupon_guid:nil complectionBlock:^(NSString *sign) {
           
            [HYAlipayManager alipayWithOrderString:sign success:^{
                
                HYPayResultViewController *payResultVC = [HYPayResultViewController new];
                payResultVC.title = @"支付成功";
                payResultVC.isPaySuccess = YES;
                payResultVC.addressMap = _orderModel.addressMap;
                [self.navigationController pushViewController:payResultVC animated:YES];
            } failed:^{
                
                HYPayResultViewController *payResultVC = [HYPayResultViewController new];
                payResultVC.title = @"支付失败";
                payResultVC.isPaySuccess = NO;
                payResultVC.addressMap = _orderModel.addressMap;
                [self.navigationController pushViewController:payResultVC animated:YES];
            }];
        }];
    }
    else{
        
        [HYPayHandle weChatPayWithOrder:self.createOrderDatalist.sorder_id coupon_guid:nil complectionBlock:^(HYWeChatPayModel *weChatPayModel) {
            
            [HYWeChatPayManager wechatPayWith:weChatPayModel];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPaySuccess:) name:KWeChatPaySuccessNotification object:nil];
        }];
    }
}

//微信支付通知
- (void)weChatPaySuccess:(NSNotification *)notification{
    
    if ([notification.object isEqualToString:@"YES"]) {
        
        HYPayResultViewController *payResultVC = [HYPayResultViewController new];
        payResultVC.title = @"支付成功";
        payResultVC.isPaySuccess = YES;
        payResultVC.addressMap = _orderModel.addressMap;
        [self.navigationController pushViewController:payResultVC animated:YES];
    }
    else{
        
        HYPayResultViewController *payResultVC = [HYPayResultViewController new];
        payResultVC.title = @"支付失败";
        payResultVC.isPaySuccess = NO;
        payResultVC.addressMap = _orderModel.addressMap;
        [self.navigationController pushViewController:payResultVC animated:YES];
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //收货地址
        static NSString *receiveAddressCell = @"receiveAddressCell";
        HYReceiveAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:receiveAddressCell];
        if (!cell) {
            cell = [[HYReceiveAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:receiveAddressCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.orderModel = _orderModel;
        return cell;
    }
    else if (indexPath.row == 1){
        
        static NSString *goodsPostageCell = @"goodsPostageCell";
        HYGoodsPostageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsPostageCell];
        if (!cell) {
            cell = [[HYGoodsPostageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsPostageCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.orderModel = _orderModel;
        return cell;
    }
    else if (indexPath.row == 2){
        
        static NSString *discountCell = @"discountCell";
        HYDiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:discountCell];
        if (!cell) {
            cell = [[HYDiscountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:discountCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if (indexPath.row == 3){
        
        static NSString *goodsPayCell = @"goodsPayCell";
        HYGoodsPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsPayCell];
        if (!cell) {
            cell = [[HYGoodsPayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsPayCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.orderModel = _orderModel;
        cell.orderPayModeBlock = ^(NSInteger mode) {
          
            self.payMode = mode;
        };
        return cell;
    }
    
    static NSString *cellID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //收货地址
        HYMyAddressViewController *myAddressVC = [HYMyAddressViewController new];
        myAddressVC.isJump = YES;
        [self.navigationController pushViewController:myAddressVC animated:YES];
        
        myAddressVC.selectAddBlock = ^(HYMyAddressModel *addressModel) {
          
            [HYGoodsHandle changeOrderReceiveAddressOrderID:_createOrderDatalist.sorder_id addressModel:addressModel ComplectionBlock:^(BOOL isSuccess) {
               
                if (isSuccess) {
                    
                    HYAddressMap *addressMap = [HYAddressMap new];
                    addressMap.province = addressModel.province;
                    addressMap.city = addressModel.city;
                    addressMap.area = addressModel.area;
                    addressMap.receiver = addressModel.receiver;
                    addressMap.address = addressModel.address;
                    addressMap.phoneNum = addressModel.phoneNum;
                    _orderModel.addressMap = addressMap;
                    [_tableView reloadData];
                }
            }];
        };
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //收货地址
        return 100;
    }
    else if (indexPath.row == 1){
        
        //商品邮费
        return 140 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 2){
        
        //优惠券
        return 50 * WIDTH_MULTIPLE;
    }
    else if (indexPath.row == 3){
        
        //商品合计
        return 145 * WIDTH_MULTIPLE;
    }
    return 100;
}


#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KCOLOR(@"f4f4f4");
    }
    return _tableView;
}

- (UILabel *)payMoneyLabel{
    
    if (!_payMoneyLabel) {
        
        _payMoneyLabel = [[UILabel alloc] init];
        _payMoneyLabel.font = KFitFont(15);
        _payMoneyLabel.textAlignment = NSTextAlignmentLeft;
        _payMoneyLabel.text = @"您需要支付:0.00";
        _payMoneyLabel.textColor = KAPP_272727_COLOR;
        _payMoneyLabel.backgroundColor = KAPP_WHITE_COLOR;
    }
    return _payMoneyLabel;
}

- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = KAPP_THEME_COLOR;
        [_confirmBtn setTitleColor:KAPP_WHITE_COLOR forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = KFitFont(18);
        _confirmBtn.layer.cornerRadius = 4;
        _confirmBtn.clipsToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

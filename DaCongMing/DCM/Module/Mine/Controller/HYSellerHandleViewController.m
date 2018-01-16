//
//  HYSellerHandleViewController.m
//  DaCongMing
//
//

#import "HYSellerHandleViewController.h"
#import "HYOrderDetailImageCell.h"
#import "HYRefundSellerHandleCell.h"

@interface HYSellerHandleViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** line */
@property (nonatomic,strong) UIView *verticalLine;

@end

@implementation HYSellerHandleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"商家处理中";
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.verticalLine];
}

- (void)viewDidLayoutSubviews{
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(40 * WIDTH_MULTIPLE);
        make.left.equalTo(self.view).offset(20 * WIDTH_MULTIPLE);
        make.width.mas_equalTo(1);
    }];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *orderDetailImageCellID = @"orderDetailImageCellID";
        HYOrderDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDetailImageCellID];
        if (!cell) {
            cell = [[HYOrderDetailImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDetailImageCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.logisticsImgView.image = [UIImage imageNamed:@"salesReturnSecondStep"];
        return cell;
    }
    else{
        
        static NSString *refundSellerHandleCellID = @"refundSellerHandleCellID";
        HYRefundSellerHandleCell *cell = [tableView dequeueReusableCellWithIdentifier:refundSellerHandleCellID];
        if (!cell) {
            cell = [[HYRefundSellerHandleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:refundSellerHandleCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 40 * WIDTH_MULTIPLE;
    }
    
    return 150 * WIDTH_MULTIPLE;
}



#pragma mark - lazyload
- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = KAPP_TableView_BgColor;
    }
    return _tableView;
}

- (UIView *)verticalLine{
    
    if (!_verticalLine) {
        
        _verticalLine = [UIView new];
        _verticalLine.backgroundColor = KCOLOR(@"dddddd");
    }
    return _verticalLine;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end

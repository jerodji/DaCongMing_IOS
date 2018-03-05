//
//  HYParterPayResultVC.m
//  DaCongMing
//
//

#import "HYParterPayResultVC.h"

@interface HYParterPayResultVC ()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *tipsLabel;

@end

@implementation HYParterPayResultVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = KAPP_TableView_BgColor;
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.tipsLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backBtnAction{
    
    KEYWINDOW.rootViewController = [HYTabBarController new];
}


- (void)viewDidLayoutSubviews{
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(80 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(100 * WIDTH_MULTIPLE);
    }];
    
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(_iconImageView.mas_bottom).offset(28 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(30 * WIDTH_MULTIPLE);
    }];
}

- (void)setIsSuccess:(BOOL)isSuccess{
    
    _isSuccess = isSuccess;
    if (isSuccess) {
        
        self.iconImageView.image = [UIImage imageNamed:@"recommend_success"];
        self.title = @"支付成功";
        self.tipsLabel.text = @"支付成功";
        
        
        //跳转App Store下载聪明管理
//        [HYAlertManager alertControllerAboveIn:self withMessage:@"是否到APP Store下载聪明管理" leftTitle:@"否" leftActionEvent:nil rightTitle:@"是" rightActionEvent:^{
//
//            NSString *urlCode = [@"聪明管理" stringByURLEncode];
//            NSString *str = [NSString stringWithFormat:
//                             @"https://itunes.apple.com/cn/app/%@/id1319732695?mt=8",urlCode];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        }];
        
        [JJAlert showAlertTitle:@"提示" msg:@"是否到App Store下载\"聪明管理\"" cancleAction:^{
            
            if ([HYUserModel sharedInstance].token && [HYUserModel sharedInstance].userInfo.id) {
                [self request_remindisread:[HYUserModel sharedInstance].token msgid:[HYUserModel sharedInstance].userInfo.id];
            }
            
        } sureAction:^{
            
            if ([HYUserModel sharedInstance].token && [HYUserModel sharedInstance].userInfo.id) {
                [self request_remindisread:[HYUserModel sharedInstance].token msgid:[HYUserModel sharedInstance].userInfo.id];
            }
            
            NSString *urlCode = [@"聪明管理" stringByURLEncode];
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/%@/id1319732695?mt=8",urlCode];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        
    } else{
        self.iconImageView.image = [UIImage imageNamed:@"recommend_fail"];
        self.title = @"支付失败";
        self.tipsLabel.text = @"支付失败";
    }
}

//API_remindisread
- (void)request_remindisread:(NSString*)token msgid:(NSString*)msgid {
    [[HTTPManager shareHTTPManager] postDataFromUrl:API_remindisread withParameter:@{@"token":token,@"id":msgid} isShowHUD:NO success:^(id returnData) {
        NSLog(@"%@",returnData)
    }];
}

#pragma mark - lazyload
- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recommend_success"]];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (UILabel *)tipsLabel{
    
    if (!_tipsLabel) {
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.font = KFitFont(14);
        _tipsLabel.textColor = KAPP_b7b7b7_COLOR;
        _tipsLabel.text = @"推荐成功";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

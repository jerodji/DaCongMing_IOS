//
//  HYTabBarController.m
//  DaCongMing
//
//

#import "HYTabBarController.h"
#import "HYBaseNavController.h"
#import "HYHomePageViewController.h"
#import "HYSortViewController.h"
#import "HYShoppingCartViewController.h"
#import "HYMineViewController.h"
#import "HYPayParterCostViewController.h"
#import "HYAlertManager.h"
#import "HYInviteParterView.h"
#import "HYGoodsListViewController.h"

@interface HYTabBarController () <UIAlertViewDelegate>
@property (nonatomic,strong) NSMutableArray * tabbarbuttonArray;
@end

@implementation HYTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CGFloat tabBarHeight = KTABBAR_HEIGHT;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, tabBarHeight)];
    backView.backgroundColor = KAPP_NAV_COLOR;
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;

    [self setupChildVC];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self checkVersion];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showInviteView];
    });
}

+ (void)initialize{
    
    [self autoLogin];
}


- (void)setupChildVC{
    //JJHomePageVC //HYHomePageViewController //HYGoodsListViewController //HYSortViewController
    NSArray *vcArray = @[@"JJHomePageVC",@"HYGoodsListViewController",@"HYShoppingCartViewController",@"HYMineViewController"];
    NSArray *titleArray = @[@"首页",@"分类",@"购物车",@"我的"];
    NSArray *imageArray = @[@"tabBar_home",@"tabBar_sort",@"tabBar_shopCarts",@"tabBar_mine"];
    NSMutableArray *navArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < vcArray.count; i++) {
        
        UIViewController *vc = [(UIViewController *)[NSClassFromString(vcArray[i]) alloc] init];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:vc];
        
        UIImage *normalImage = [UIImage imageNamed:imageArray[i]];
        UIImage *selectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",imageArray[i]]];
        vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.title = titleArray[i];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : KAPP_THEME_COLOR} forState:UIControlStateSelected];
        
        nav.navigationBar.tintColor = KAPP_THEME_COLOR;
        
        //将文字上移
        [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
}

+ (void)autoLogin{
    
    if ([[KUSERDEFAULTS valueForKey:KUserLoginType] isEqualToString:@"phone"]) {

        NSString *phone = [KUSERDEFAULTS valueForKey:KUserPhone];
        NSString *password = [KUSERDEFAULTS valueForKey:KUserPassword];
        [HYUserHandle userLoginWithPhone:phone password:password complectionBlock:^(BOOL isLoginSuccess) {
            
            if (isLoginSuccess) {
                
                NSLog(@"自动登录成功");
            }
        }];
    }
    
    HYUserModel *userModel = [HYPlistTools unarchivewithName:KUserModelData];
    HYUserModel *shareModel = [HYUserModel sharedInstance];
    shareModel.token = userModel.token;
    shareModel.userInfo = userModel.userInfo;
    NSLog(@"user:---%@",shareModel);
    if ([[KUSERDEFAULTS valueForKey:KUserLoginType] isEqualToString:@"weChat"]) {
        
        [HYUserHandle getMyUserInfoComplectionBlock:^(HYUserModel *userModel) {
           
            if (userModel) {
                NSLog(@"微信用户刷新数据成功");
            }
        }];
    }
    
    
   
    
}

#pragma mark - tabBar动画
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
    NSLog(@"%ld",index);
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    
    if (IsNull(_tabbarbuttonArray)) {
        _tabbarbuttonArray = [NSMutableArray array];
        for (UIView *tabBarButton in self.tabBar.subviews) {
            if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [_tabbarbuttonArray addObject:tabBarButton];
            }
        }
    }

    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount = 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.9];
    pulse.toValue= [NSNumber numberWithFloat:1.1];
    [[_tabbarbuttonArray[index] layer] addAnimation:pulse forKey:@"tabBarItemAnimation"];
    
}

#pragma mark - 检查版本更新
- (void)checkVersion{
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurrentVer = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",APPID];
    
    //1.创建请求管理者
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer.timeoutInterval = 20;
    //4.设置请求的类型
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            
            NSArray *array = [responseObject objectForKey:@"results"];
            NSString *appStoreVersion = [[array lastObject] objectForKey:@"version"];
            NSLog(@"AppStore版本:%@",appStoreVersion);
            if ([appStoreVersion compare:appCurrentVer options:NSNumericSearch] == NSOrderedDescending) {
                
                //App Store版本大于当前版本，提示更新
                [HYAlertManager alertControllerAboveIn:self withMessage:@"大聪明有新版本了，是否更新" leftTitle:@"否" leftActionEvent:nil rightTitle:@"是" rightActionEvent:^{
                    
                    NSString *urlCode = [@"大聪明" stringByURLEncode];
                    NSString *str = [NSString stringWithFormat:
                                     @"https://itunes.apple.com/cn/app/%@/id1301986941?mt=8",urlCode];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }];
                
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)showInviteView{
    
    //判断是不是第一次使用
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstAlertInvite"]){
        
        if ([[HYUserModel sharedInstance].userInfo.userRemind.type isNotBlank]) {
            
            HYInviteParterView *inviteView = [[HYInviteParterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [self.view addSubview:inviteView];
            [inviteView showInviteView];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstAlertInvite"];
            
            inviteView.payBlock = ^{
                
                HYPayParterCostViewController *payVC = [HYPayParterCostViewController new];
                HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:payVC];
                [self presentViewController:nav animated:YES completion:nil];
            };
        }
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end

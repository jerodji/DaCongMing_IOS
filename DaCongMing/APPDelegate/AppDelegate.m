


#import "AppDelegate.h"
#import "HYTabBarController.h"
#import "HYLoginViewController.h"
#import "HYGuideViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <Bugly/Bugly.h>
#import "QYSDK.h"
#import <UMMobClick/MobClick.h>
#import "HYShareView.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // po [UIFont familyNames]
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames ){
//        printf( "Family: %s \n", [familyName UTF8String] );
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in [UIFont familyNames] ){
//            printf( "\tFont: %s \n", [fontName UTF8String] );
//        }
//    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KAPP_TableView_BgColor;
    [self.window makeKeyAndVisible];
    
    [DCURLRouter loadConfigDictFromPlist:@"DCURLRouter.plist"];
    
    //让键盘自适应高度
    IQKeyboardManager *manager= [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    //判断是不是第一次使用
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstLaunch"];
        HYGuideViewController *guideVC = [[HYGuideViewController alloc] init];
        self.window.rootViewController = guideVC;
    }
    else{
        
        HYTabBarController *tabBar = [[HYTabBarController alloc] init];
        self.window.rootViewController = tabBar;
    }
    
    [Bugly startWithAppId:TencentBuglyID];
    [[QYSDK sharedSDK] registerAppId:QIYUAPPID appName:@"大聪明"];
    UMConfigInstance.appKey = UMengAPPKey;
    [MobClick startWithConfigure:UMConfigInstance];
    
//    HYLoginViewController *loginVC = [[HYLoginViewController alloc] init];
//    self.window.rootViewController = loginVC;
    
    [WXApi registerApp:WXAppID];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    
    [WXApi handleOpenURL:url delegate:self];

    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length > 0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

/**
 *  微信回调
 */
- (void)onResp:(BaseResp *)resp{
    
    NSLog(@"WeChat login callBack errorCode %@",resp.errStr);
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        //微信登录授权
        if (resp.errCode == 0) {
            //登录成功 发出通知
            SendAuthResp *atuhResp = (SendAuthResp *)resp;
            [[NSNotificationCenter defaultCenter] postNotificationName:KWeChatLoginNotification object:atuhResp.code];
        }
    }
    
    //微信支付回调
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp*)resp;
        
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:KWeChatPaySuccessNotification object:@"YES"];
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:KWeChatPaySuccessNotification object:@"NO"];
                break;
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //HYShareView
    UIView* curtView = [[UIApplication sharedApplication].windows lastObject].subviews.lastObject;
    if ([curtView isKindOfClass:[HYShareView class]]) {
        [curtView removeFromSuperview];
        curtView = nil;
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

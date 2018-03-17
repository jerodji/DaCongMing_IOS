//
//  AppDelegate+UMPush.m
//  DaCongMing
//
//  Created by hailin on 2018/3/12.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "AppDelegate+UMPush.h"

@implementation AppDelegate (UMPush)

NSString* const UMAppKey = @"5aa5f97df29d98223b0000f8";


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // deviceToken 转换 string
    NSMutableString *deviceTokenStr = [NSMutableString string];
    const char * bytes   = deviceToken.bytes;
    unsigned long iCount = deviceToken.length ;
    for (int i = 0; i < iCount; i++) {
        [deviceTokenStr appendFormat:@"%02x", bytes[i]&0x000000FF];
    }
    
    NSLog(@"deviceToken : %@",deviceTokenStr);
    
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    [UMessage registerDeviceToken:deviceToken];
}

- (void)initUMPush:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    // 配置友盟SDK产品并并统一初始化
//    // [UMConfigure setEncryptEnabled:YES]; // optional: 设置加密传输, 默认NO.
//    // [UMConfigure setLogEnabled:YES]; // 开发调试时可在console查看友盟日志显示，发布产品必须移除。
//    [UMConfigure initWithAppkey:UMAppKey channel:@"App Store"];
//    /* appkey: 开发者在友盟后台申请的应用获得（可在统计后台的 “统计分析->设置->应用信息” 页面查看）*/
//
//    // 统计组件配置
//    //[MobClick setScenarioType:E_UM_NORMAL];
//    // [MobClick setScenarioType:E_UM_GAME];  // optional: 游戏场景设置
//
//    // Push组件基本功能配置
//    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
//    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
//    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标等
//    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
////    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:nil completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 用户选择了接收Push消息
        }else{
            // 用户拒绝接收Push消息
        }
    }];
    
    
    // 请参考「Share详细介绍-初始化第三方平台」
    // 分享组件配置，因为share模块配置可选三方平台较多，代码基本跟原版一样，也可下载demo查看
//    [self configUSharePlatforms];   // required: setting platforms on demand
    
    // ...
    
    #pragma mark -
    
    
//    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {

        //iOS10必须加下面这段代码。
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions types10 = UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                //这里可以添加一些自己的逻辑
            } else {
                //点击不允许
                //这里可以添加一些自己的逻辑
            }
        }];


//        //如果要在iOS10显示交互式的通知，必须注意实现以下代码
//        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
//        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
//
//        //UNNotificationCategoryOptionNone
//        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
//        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
//        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category101" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
//        NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
//        [center setNotificationCategories:categories_ios10];
//    }
//
//    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
//    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title=@"打开应用";
//        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//        action2.identifier = @"action2_identifier";
//        action2.title=@"忽略";
//        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//        action2.destructive = YES;
//        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
//        actionCategory1.identifier = @"category1";//这组动作的唯一标示
//        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
//        [UMessage registerForRemoteNotifications:categories];
//    }
    
    
    
    
    
    
}

/*
 注意：实现
 -(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
 会覆盖
 -(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
 这个方法，建议使用前者。
 */

//iOS10以下使用这两个方法接收通知，
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        
        //    self.userInfo = userInfo;
        //    //定制自定的的弹出框
        //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        //    {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
        //                                                            message:@"Test On ApplicationStateActive"
        //                                                           delegate:self
        //                                                  cancelButtonTitle:@"确定"
        //                                                  otherButtonTitles:nil];
        //
        //        [alertView show];
        //
        //    }
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //关闭友盟自带的弹出框
//    [UMessage setAutoAlert:NO];
//    [UMessage didReceiveRemoteNotification:userInfo];
//
//    //    self.userInfo = userInfo;
//    //    //定制自定的的弹出框
//    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    //    {
//    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
//    //                                                            message:@"Test On ApplicationStateActive"
//    //                                                           delegate:self
//    //                                                  cancelButtonTitle:@"确定"
//    //                                                  otherButtonTitles:nil];
//    //
//    //        [alertView show];
//    //
//    //    }
//
//}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo]; //统计点击数
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}
/*
 注意：如需关闭推送，请使用unregisterForRemoteNotifications，(iOS10此功能存在系统bug,建议不要在iOS10使用。iOS10出现的bug会导致关闭推送后无法打开推送。
 */



@end

//
//  AppDelegate+UMPush.h
//  DaCongMing
//
//  Created by hailin on 2018/3/12.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "AppDelegate.h"

#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
//#import <UMAnalytics/MobClick.h>        // 统计组件
//#import <UMShare/UMShare.h>    // 分享组件
#import <UMPush/UMessage.h>             // Push组件
#import <UserNotifications/UserNotifications.h>  // Push组件必须的系统库
/* 开发者可根据功能需要引入相应组件头文件，并导入相应组件库*/


@interface AppDelegate (UMPush)<UNUserNotificationCenterDelegate>

UIKIT_EXTERN NSString* const UMAppKey;

- (void)initUMPush:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

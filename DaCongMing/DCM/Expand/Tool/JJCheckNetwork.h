//
//  JJCheckNetwork.h
//  DaCongMing
//
//  Created by hailin on 2018/3/31.
//  Copyright © 2018年 SaBai. All rights reserved.
//
/**
 CoreTelephony.framework
 SystemConfiguration.framework
 */


#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTCellularData.h>
//#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

#import <Foundation/Foundation.h>

@interface JJCheckNetwork : NSObject

/**
 监控蜂窝数据限制状态
 当联网权限的状态发生改变时，会在下述方法中捕捉到改变后的状态，可根据更新后的状态执行相应的操作
 */
+ (void)monitorCellularState:(void(^)(int netState))changeCB;

/**
 获取网络权限
 0 关闭
 1 仅wifi
 2 流量+wifi
 */
+ (int)checkNetworkPermission;

/**
 检查网络状态
 0 没有网络
 1 Wifi网络
 2 蜂窝网络
 */
+ (int)checkInternetStatus;

/**
 使用这种方法时一定要保证statusbar没有隐藏。
 如果App隐藏了statusbar，就不能通过这种方法获得网络状态。
 @return 2G 3G 4G LTE wifi
 */
+ (NSString *)networkingStatesFromStatebar;




@end

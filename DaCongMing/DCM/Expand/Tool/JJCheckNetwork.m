//
//  JJCheckNetwork.m
//  DaCongMing
//
//  Created by hailin on 2018/3/31.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "JJCheckNetwork.h"

@implementation JJCheckNetwork

static CTCellularData* _ins = nil;
+ (CTCellularData*)instance
{
    if (!_ins) {
        _ins = [[CTCellularData alloc]init];
    }
    return _ins;
}

/**
 监控蜂窝数据限制状态
 当联网权限的状态发生改变时，会在下述方法中捕捉到改变后的状态，可根据更新后的状态执行相应的操作
 */
+ (void)monitorCellularState:(void(^)(int netState))changeCB
{
//    CTCellularData *cellularData = [[CTCellularData alloc]init];
    self.instance.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
        //状态改变时进行相关操作
        switch (state) {
            case kCTCellularDataRestricted:
//                net = 1;
                changeCB(1);
                break;
            case kCTCellularDataNotRestricted:
//                net = 2;
                changeCB(2);
                break;
            case kCTCellularDataRestrictedStateUnknown:
//                net = 0;
                changeCB(0);
                break;
            default:
                break;
        };
    };
}

/**
 获取网络权限
 0 关闭
 1 仅wifi
 2 流量+wifi
 */
+ (int)checkNetworkPermission
{
    __block int net = -1;
    CTCellularDataRestrictedState state = self.instance.restrictedState;
    switch (state) {
        case kCTCellularDataRestricted:
//            NSLog(@"Restricrted");
            net = 1;
            break;
        case kCTCellularDataNotRestricted:
            net = 2;
//            NSLog(@"Not Restricted");
            break;
        case kCTCellularDataRestrictedStateUnknown:
//            NSLog(@"Unknown");
            net = 0;
            break;
        default:
            break;
    }

    NSLog(@">>>>>>>>>>>>>>> %d",net);
    return net;
}

/**
 检查网络状态
 HostName改成”www.baidu.com”或者其他中国网站时经常会获取网络状态错误，不能得到正确的网络状态。所以最好使用苹果的网站“www.apple.com”
 这种方法是目前最普遍的使用方式，由于是苹果官方demo，所以比较权威。但是这种方法的缺点是不能知道用户使用的手机网络是2G、3G还是4G。
 0 没有网络
 1 Wifi网络
 2 蜂窝网络
 */
+ (int)checkInternetStatus
{
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    int net = 1;
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = 1;
            break;
            
        case ReachableViaWWAN:
            net = 2;
            break;
            
        case NotReachable:
            net = 0;
            
        default:
            break;
    }
    
    return net; 
}


#pragma mark 获取网络类型
//使用这种方法时一定要保证statusbar没有隐藏。
//如果App隐藏了statusbar，就不能通过这种方法获得网络状态。

+ (int)networkingStates
{
    UIApplication* app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    return type;
}

+ (NSString *)networkingStatesFromStatebar
{
    int type = [self networkingStates];
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
    
}


@end

//
//  JJTimer.m
//  UnicornTV
//
//  Created by JerodJi on 2017/11/25.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import "JJTimer.h"

@interface JJTimer()

@end

@implementation JJTimer

//+ (instancetype)shareIns
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        ins = [[[self class] alloc] init];
//    });
//    return ins;
//}

- (void)beginGCDTimer {
    if (self.timer && self.timer) {
        //默认是暂停的,要手动启动
        dispatch_resume(self.timer);
    }
}

- (void)cancelGCDTimer {
    if (self.timer) {
        dispatch_cancel(self.timer);
    }
}

- (dispatch_source_t)getGCDTimer {
    if (self.timer) {
        return self.timer;
    }
    return nil;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        //获得队列
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        //创建一个定时器
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }
    return self;
}

- (void)taskWithInterval:(double)interval action:(void(^)())actionBlock {
    if (!self.timer) {
//        //获得队列
//        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//        //创建一个定时器
//        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        return;
    }
    //设置时间间隔
    //    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    NSTimeInterval period = interval;
    //设置定时器
    //    dispatch_source_set_timer(self.timer, start, interval, 0);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        actionBlock();
    });
}

- (void)taskWithInterval:(double)interval callback:(SEL)sel {
    if (!self.timer) {
        return;
    }
    NSTimeInterval period = interval;
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        if (sel) {
            [self performSelector:@selector(sel) withObject:nil];
        }
    });
}


@end

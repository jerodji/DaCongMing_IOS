//
//  JJTimer.h
//  UnicornTV
//
//  Created by JerodJi on 2017/11/25.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJTimer : NSObject

@property (nonatomic, strong) dispatch_source_t timer;

- (instancetype)init;

- (void)taskWithInterval:(double)interval action:(void(^)())actionBlock;
- (void)taskWithInterval:(double)interval callback:(SEL)sel;

- (void)beginGCDTimer;
- (void)cancelGCDTimer;

@end

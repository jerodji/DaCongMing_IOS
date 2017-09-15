//
//  TitleRoll.m
//  TitleRoll
//
//  Created by Jackhu on 2017/2/27.
//  Copyright © 2017年 Jackhu. All rights reserved.
//
//

#import "TitleRoll.h"

@interface TitleRoll()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,copy)   NSArray *infoArray;
@property (nonatomic,assign) NSInteger infoCount;

@end

@implementation TitleRoll

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-  (void)setStringArray:(NSArray *)array rollDuration:(CGFloat)seconds{

    _label = [[UILabel alloc] initWithFrame:self.bounds];
    //_label.backgroundColor = [UIColor grayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:16];
    _label.textColor = [UIColor blackColor];
    _label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
    [_label addGestureRecognizer:tapGes];
    [self addSubview:_label];
    
    if (array.count == 0) {
        _label.text = @"暂无活动";
    }
    else{
        self.infoArray = array;
        _label.text = array[0];
        [self beginTimerWithDuration:seconds];
    }
    
}
#pragma mark -- 开始计时器
- (void)beginTimerWithDuration:(CGFloat)duration{
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:duration]];
    }
}

//计时器调用的方法
- (void)timerMethod{
    
    [self fadeLayer:self.label.layer];
    
    _infoCount++;
    if (_infoCount == self.infoArray.count) {
        _infoCount = 0;
    }
    self.label.text = self.infoArray[_infoCount];
}

/**渐隐*/
- (void)fadeLayer:(CALayer *)layer{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    //动画的过渡类型
    //push新视图把旧视图推出去
    //cube立方体翻转效果
    animation.type =  @"cube";
    //动画的子类型
     animation.subtype = kCATransitionFromTop;
    //timingFunction:控制动画进行的节奏
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
   
    [layer addAnimation:animation forKey:@"titleRollAnimation"];
}

- (void)labelTap:(UITapGestureRecognizer *)tap{
    
    NSLog(@"点击了Label");
    NSLog(@"---%@",self.label.text);
}

@end

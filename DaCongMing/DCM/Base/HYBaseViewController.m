//
//  HYBaseViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseViewController ()

@end

@implementation HYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    self.edgesForExtendedLayout = UIRectEdgeNone;

}


- (void)viewWillDisappear:(BOOL)animated{
    
    [self.view endEditing:YES];
}

- (void)setupNav{
    
    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor = KAPP_NAV_COLOR;
    //设置导航栏的字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:KAPP_WHITE_COLOR}];
    self.navigationController.navigationBar.translucent = NO;
    
    //设置返回按钮的颜色为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark - setStatusBar
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    [super preferredStatusBarStyle];
    return UIStatusBarStyleLightContent;
}


//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = color;
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end

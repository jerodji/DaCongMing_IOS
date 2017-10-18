//
//  HYBaseNavController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYBaseNavController.h"

@interface HYBaseNavController () <UINavigationControllerDelegate>

@end

@implementation HYBaseNavController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.delegate = self;
    
}

#pragma mark --------navigation delegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    

    if (self.viewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.highlighted = NO;
//        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        backButton.frame = CGRectMake(0,0,30,30);
//        [backButton addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backBtnAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

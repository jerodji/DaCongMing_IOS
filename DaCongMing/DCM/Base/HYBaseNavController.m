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
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backBtnAction{
    
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HYTabBarController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/15.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYTabBarController.h"
#import "HYBaseNavController.h"

#import "HYHomePageViewController.h"
#import "HYSortViewController.h"
#import "HYShoppingCartViewController.h"
#import "HYMineViewController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 49)];
    backView.backgroundColor = KAPP_NAV_COLOR;
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    
    [self setupChildVC];
}

- (void)setupChildVC{
    
    NSArray *vcArray = @[@"HYHomePageViewController",@"HYSortViewController",@"HYShoppingCartViewController",@"HYMineViewController"];
    NSArray *titleArray = @[@"首页",@"分类",@"购物车",@"我的"];
    NSArray *imageArray = @[@"tabBar_home",@"tabBar_sort",@"tabBar_shopCarts",@"tabBar_mine"];
    NSMutableArray *navArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < vcArray.count; i++) {
        
        UIViewController *vc = [(UIViewController *)[NSClassFromString(vcArray[i]) alloc] init];
        HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:vc];
        
        UIImage *normalImage = [UIImage imageNamed:imageArray[i]];
        UIImage *selectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",imageArray[i]]];
        vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.title = titleArray[i];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : KAPP_THEME_COLOR} forState:UIControlStateSelected];
        nav.navigationBar.tintColor = KAPP_THEME_COLOR;
        [navArray addObject:nav];
    }
    
    self.viewControllers = navArray;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    
    
}



@end

//
//  JJSearchController.m
//  DaCongMing
//
//  Created by hailin on 2018/1/19.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "JJSearchController.h"
#import "HYHomeSearchViewController.h"
#import "HYBaseNavController.h"

@implementation JJSearchController

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotySearchResultJumpURL object:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        __weak typeof(self) wkself = self;
        _searchBar = [JJSearchBar loadXIB];
        _searchBar.beginEditCB = ^{
            [wkself willGotoSearchVCWithSearchText:nil];
        };
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchResult:) name:NotySearchResultJumpURL object:nil];
    }
    return self;
}

- (void)searchResult:(NSNotification*)noty {
    self.jumpUrl = [noty.object objectForKey:@"jumpUrl"];
}

- (void)willGotoSearchVCWithSearchText:(NSString*)text {
    HYHomeSearchViewController * searchVC = [[HYHomeSearchViewController alloc] init];
    searchVC.jumpUrl = self.jumpUrl;
    HYBaseNavController * vc = (HYBaseNavController*)self.searchBar.viewController;
    [vc pushViewController:searchVC animated:YES];
    
}

- (void)searchBarShow {
    self.searchBar.alpha = 0.5;
}

- (void)searchBarHidden {
    self.searchBar.alpha = 0;
}

@end

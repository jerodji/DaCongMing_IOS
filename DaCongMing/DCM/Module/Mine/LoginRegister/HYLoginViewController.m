//
//  HYLoginViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYLoginViewController.h"
#import "HYLoginView.h"
#import "HYCompleteInfoViewController.h"

@interface HYLoginViewController ()

/** loginView */
@property (nonatomic,strong) HYLoginView *loginView;

/** bg */
@property (nonatomic,strong) UIImageView *bgImgView;

@end

@implementation HYLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.loginView];
    
    __weak typeof (self) weakSelf = self;
    _loginView.weChatBlock = ^{
      
        HYCompleteInfoViewController *completeInfoVC = [[HYCompleteInfoViewController alloc] init];
        [weakSelf presentViewController:completeInfoVC animated:YES completion:nil];
    };
}

#pragma mark - lazyload
- (UIImageView *)bgImgView{

    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImgView.image = [UIImage imageNamed:@"loginBg"];
    }
    return _bgImgView;
}

- (HYLoginView *)loginView{
    
    if (!_loginView) {
        
        _loginView = [[HYLoginView alloc] initWithFrame:self.view.bounds];
    }
    return _loginView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end

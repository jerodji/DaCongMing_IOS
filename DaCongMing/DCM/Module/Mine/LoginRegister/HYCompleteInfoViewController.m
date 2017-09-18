//
//  HYCompleteInfoViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/18.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYCompleteInfoViewController.h"
#import "HYCompleteView.h"

@interface HYCompleteInfoViewController ()

/** loginView */
@property (nonatomic,strong) HYCompleteView *complecteView;

/** bg */
@property (nonatomic,strong) UIImageView *bgImgView;

@end

@implementation HYCompleteInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.complecteView];
}

- (UIImageView *)bgImgView{
    
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImgView.image = [UIImage imageNamed:@"loginBg"];
    }
    return _bgImgView;
}

- (HYCompleteView *)complecteView{
    
    if (!_complecteView) {
        
        _complecteView = [[HYCompleteView alloc] initWithFrame:self.view.bounds];
    }
    return _complecteView;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}



@end

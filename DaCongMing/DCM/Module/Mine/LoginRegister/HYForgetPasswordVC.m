//
//  HYForgetPasswordVC.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/17.
//  Copyright © 2017年 胡勇. All rights reserved.
//

/**
 *  手机验证VC
 */

#import "HYForgetPasswordVC.h"
#import "HYAuthPhoneView.h"
#import "HYSetPasswordViewController.h"
#import "HYSetLoginPwdViewController.h"

@interface HYForgetPasswordVC ()

/** 验证密码 */
@property (nonatomic,strong) HYAuthPhoneView *authPhoneView;

@end

@implementation HYForgetPasswordVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
    
    __weak typeof (self)weakSelf = self;
    _authPhoneView.authPhoneSuccess = ^{
        
        if (weakSelf.isBindPhone) {
            
            
            [MBProgressHUD showPregressHUD:KEYWINDOW withText:@"绑定手机成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else{
            
            HYSetPasswordViewController *setPwdVC = [HYSetPasswordViewController new];
            setPwdVC.phone = weakSelf.authPhoneView.phoneTextField.text;
            setPwdVC.authCode = weakSelf.authPhoneView.authCodeTextField.text;
            [weakSelf.navigationController pushViewController:setPwdVC animated:YES];
        }
    };
    
}
 - (void)setupSubviews{
    
     if (self.isBindPhone) {
         
         self.title = @"绑定手机";
     }
     else{
         
         self.title = @"手机验证";
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
         self.navigationItem.leftBarButtonItem = backItem;
     }
     
     [self.view addSubview:self.authPhoneView];
 }

- (void)viewDidLayoutSubviews{
    
    [_authPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - action
- (void)backAction{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - lazyload
- (HYAuthPhoneView *)authPhoneView{
    
    if (!_authPhoneView) {
        
        _authPhoneView = [HYAuthPhoneView new];
    }
    return _authPhoneView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

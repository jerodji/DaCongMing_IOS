//
//  FinishCommitVC.m
//  DaCongMing
//
//  Created by hailin on 2018/2/2.
//  Copyright © 2018年 SaBai. All rights reserved.
//

#import "FinishCommitVC.h"
#import "HYPayParterCostViewController.h"

//@class HYPayParterCostViewController;

@interface FinishCommitVC ()
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;
@end

@implementation FinishCommitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡支付";
    _sureButton.layer.cornerRadius = 5;
    

    _bottomConst.constant = 10 + KSafeAreaBottom_Height;
}

- (IBAction)sureBtn:(id)sender {
    //NSLog(@"sure");
    for (UIViewController* vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[HYPayParterCostViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  HYInvitateFriendsViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYInvitateFriendsViewController.h"
#import "HYShareView.h"

@interface HYInvitateFriendsViewController ()

/** 背景图 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** shareBtn */
@property (nonatomic,strong) UIButton *shareBtn;

@end

@implementation HYInvitateFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"邀请好友";
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.shareBtn];
}

- (void)viewDidLayoutSubviews{
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.left.bottom.equalTo(self.view);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view).offset(-60 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(55 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self.view);
    }];
}

#pragma mark - action
- (void)inviteAction{
    
    
}

#pragma mark - lazyLoad
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"invitateBg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (UIButton *)shareBtn{
    
    if (!_shareBtn) {
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shareBg"] forState:UIControlStateNormal];
        _shareBtn.highlighted = NO;
        [_shareBtn addTarget:self action:@selector(inviteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
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

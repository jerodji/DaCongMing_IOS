//
//  HYMyQRCodeViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyQRCodeViewController.h"

@interface HYMyQRCodeViewController ()

/** 背景图 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** 二维码 */
@property (nonatomic,strong) UIImageView *QRImageView;

@end

@implementation HYMyQRCodeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    self.title = @"我的二维码";
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.QRImageView];
}

- (void)viewDidLayoutSubviews{
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.left.bottom.equalTo(self.view);
    }];
    
    [_QRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(179 * WIDTH_MULTIPLE);
        make.left.equalTo(self.view).offset(107 * WIDTH_MULTIPLE);
        make.right.equalTo(self.view).offset(-119 * WIDTH_MULTIPLE);
        make.bottom.equalTo(self.view).offset(-285 * WIDTH_MULTIPLE);

    }];
}

#pragma mark - lazyLoad
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"qrCodeBg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

#pragma mark - lazyLoad
- (UIImageView *)QRImageView{
    
    if (!_QRImageView) {
        
        _QRImageView = [UIImageView new];
        _QRImageView.image = [UIImage imageNamed:@"myQrCode"];
        _QRImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _QRImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  HYMyQRCodeViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/9/27.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYMyQRCodeViewController.h"
#import "HYShareView.h"

@interface HYMyQRCodeViewController ()

/** 背景图 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** 二维码 */
@property (nonatomic,strong) UIImageView *QRImageView;
/** share */
@property (nonatomic,strong) HYShareView *shareView;

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
    
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareQRCodeAction)];
    self.navigationItem.rightBarButtonItem = shareButtonItem;
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

#pragma mark - action
- (void)shareQRCodeAction{
    
    [KEYWINDOW addSubview:self.shareView];
    [self.shareView showShareView];
}

#pragma mark - lazyLoad
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"QRCodeBg"];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}

- (UIImageView *)QRImageView{
    
    if (!_QRImageView) {
        
        _QRImageView = [UIImageView new];
        [_QRImageView sd_setImageWithURL:[NSURL URLWithString:[HYUserModel sharedInstance].userInfo.qrpath] placeholderImage:[UIImage imageNamed:@""]];
        _QRImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _QRImageView;
}

- (HYShareView *)shareView{
    
    if (!_shareView) {
        
        _shareView = [[HYShareView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"大聪明" forKey:@"shareTitle"];
        [dict setObject:[HYUserModel sharedInstance].userInfo.qrpath forKey:@"shareImgUrl"];
        [dict setObject:@"我的二维码" forKey:@"shareDesc"];
        
        _shareView.shareDict = dict;
    }
    return _shareView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

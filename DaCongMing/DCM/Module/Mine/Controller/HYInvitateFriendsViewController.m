//
//  HYInvitateFriendsViewController.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/11.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYInvitateFriendsViewController.h"
#import "HYShareView.h"
#import "HYMineNetRequest.h"

@interface HYInvitateFriendsViewController ()

/** 背景图 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** shareBtn */
@property (nonatomic,strong) UIButton *shareBtn;
/** share */
@property (nonatomic,strong) HYShareView *shareView;

@end

@implementation HYInvitateFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestNetWork];
}

- (void)setupSubviews{
    
    self.title = @"邀请好友";
    self.view.backgroundColor = KCOLOR(@"f4f4f4");
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(inviteAction)];
    self.navigationItem.rightBarButtonItem = shareItem;
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.shareBtn];
}

- (void)viewDidLayoutSubviews{
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.left.bottom.equalTo(self.view);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(180 * WIDTH_MULTIPLE);
        make.height.mas_equalTo(70 * WIDTH_MULTIPLE);
        make.left.right.equalTo(self.view);
    }];
}

- (void)requestNetWork{
    
    [HYMineNetRequest getMyShareWithComplectionBlock:^(NSDictionary *shareDict) {
        
        if (shareDict) {
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:@"大聪明" forKey:@"shareTitle"];
            [dict setObject:shareDict[@"url"] forKey:@"shareUrl"];
            [dict setObject:shareDict[@"title_image_url"] forKey:@"imageUrl"];
            [dict setObject:shareDict[@"share_msg"] forKey:@"shareDesc"];
            
            self.shareView.shareDict = dict;
        }
    }];
}

#pragma mark - action
- (void)inviteAction{
    
    [KEYWINDOW addSubview:self.shareView];
    [self.shareView showShareView];
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
        _shareBtn.backgroundColor = [UIColor clearColor];
        _shareBtn.highlighted = NO;
        [_shareBtn addTarget:self action:@selector(inviteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (HYShareView *)shareView{
    
    if (!_shareView) {
        
        _shareView = [[HYShareView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    }
    return _shareView;
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

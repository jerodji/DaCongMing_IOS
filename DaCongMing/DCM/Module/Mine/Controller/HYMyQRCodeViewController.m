//
//  HYMyQRCodeViewController.m
//  DaCongMing
//
//

#import "HYMyQRCodeViewController.h"
#import "HYShareView.h"
#import "HYShareModel.h"

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
    
    self.title = @"我的二维码";
    self.view.backgroundColor = KAPP_WHITE_COLOR;
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareQRCodeAction)];
    self.navigationItem.rightBarButtonItem = shareButtonItem;
    
//    self.bgImageView.frame = self.view.bounds;
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.QRImageView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.right.left.bottom.equalTo(self.view);
    }];
    
    
    CGFloat T = 179 * WIDTH_MULTIPLE;
    CGFloat L = 107 * WIDTH_MULTIPLE;
    CGFloat R = -119 * WIDTH_MULTIPLE;
    CGFloat B = -285 * WIDTH_MULTIPLE;
    if (IS_IPHONE_X) {
        T = 179 * WIDTH_MULTIPLE - 20;
        L = 107 * WIDTH_MULTIPLE - 5;
        R = -119 * WIDTH_MULTIPLE;
        B = -285 * WIDTH_MULTIPLE;
    }
    
    [self.QRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(T);
        make.left.equalTo(self.view).offset(L);
        make.right.equalTo(self.view).offset(R);
        make.bottom.equalTo(self.view).offset(B);
        
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//}
//- (void)viewDidLayoutSubviews{
//
//    [super viewDidLayoutSubviews];
    
//    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.right.left.bottom.equalTo(self.view);
//    }];
    
    
    
//    [self.QRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(self.view).offset(179 * WIDTH_MULTIPLE);
//        make.left.equalTo(self.view).offset(107 * WIDTH_MULTIPLE);
//        make.right.equalTo(self.view).offset(-119 * WIDTH_MULTIPLE);
//        make.bottom.equalTo(self.view).offset(-285 * WIDTH_MULTIPLE);
//
//    }];
}

#pragma mark - action
- (void)shareQRCodeAction{
    
    [KEYWINDOW addSubview:self.shareView];
    [self.shareView showShareView];
    
    UIImage* scren = [self getScreenShot];
    
    HYShareModel *model = [[HYShareModel alloc] init];
    model.shareType = HYShareTypeImage;
    model.thumbnailImage = [UIImage imageNamed:@"AppIcon"];
    model.image = scren;
    self.shareView.shareModel = model;
}

//截图
- (UIImage *)getScreenShot{
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

#pragma mark - lazyLoad
- (UIImageView *)bgImageView{
    
    if (!_bgImageView) {
        
        UIImage* img = [UIImage imageNamed:@"QRCodeBg"];
//        img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
        
        if (IS_IPHONE_X) {
            img = [UIImage imageNamed:@"erweimatu"];
        }
        
        _bgImageView = [UIImageView new];
//        _bgImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - KNAV_HEIGHT);
        [_bgImageView setImage:img];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.layer.masksToBounds = YES;
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
    }
    return _shareView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

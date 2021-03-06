//
//  HYCompleteInfoViewController.m
//  DaCongMing
//
//

#import "HYCompleteInfoViewController.h"
#import "HYCompleteView.h"
#import "HYSetPasswordViewController.h"

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
    
    __weak typeof (self)weakSelf = self;
    self.complecteView.confirmBlock = ^(NSString *phone) {
       
        HYSetPasswordViewController *setPasswordVC = [[HYSetPasswordViewController alloc] init];
        setPasswordVC.phone = phone;
        [weakSelf presentViewController:setPasswordVC animated:YES completion:nil];
    };
}

- (void)setIsBindPhone:(BOOL)isBindPhone{
    
    _isBindPhone = isBindPhone;
    [self.view addSubview:self.complecteView];
    self.complecteView.skipBtn.hidden = isBindPhone;
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

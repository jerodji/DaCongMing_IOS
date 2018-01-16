//
//  HYBaseNavController.m
//  DaCongMing
//
//

#import "HYBaseNavController.h"

@interface HYBaseNavController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImageView *screenshotImgView;
@property(strong, nonatomic) UIView * coverView;
@property(strong, nonatomic)  NSMutableArray * screenshotImgArray;
@property(strong, nonatomic)  UIScreenEdgePanGestureRecognizer *panGestureRec;

@end

@implementation HYBaseNavController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
    self.delegate = self;
    _screenshotImgArray = [NSMutableArray array];

}

- (void)createGesture{
    
    //创建边缘手势
    _panGestureRec = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    _panGestureRec.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_panGestureRec];
    
    //创建截图
    _screenshotImgView = [UIImageView new];
    _screenshotImgView.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    
    //创建截图上面的黑色半透明遮罩
    _coverView = [UIView new];
    _coverView.frame = _screenshotImgView.frame;
    _coverView.backgroundColor = KAPP_BLACK_COLOR;
    
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan{
    
    if (!self.viewControllers.count) {
        return;
    }
    
    switch (_panGestureRec.state) {
        case UIGestureRecognizerStateBegan:
            //开始拖拽
            [self beginDrag];
            break;
        case UIGestureRecognizerStateEnded:
            //结束拖拽
            [self endDrag];
            break;
        default:
            //正在拖拽
            [self draggingWithPan:pan];
            break;
    }
}

#pragma mark - 拖动
- (void)beginDrag{
    
    //每次开始pan手势，都要添加截图和遮罩
    [self.view.window insertSubview:_screenshotImgView atIndex:0];
    [self.view.window insertSubview:_coverView aboveSubview:_screenshotImgView];
    
    //让imageView显示截图数组中的最后一张
    _screenshotImgView.image = [_screenshotImgArray lastObject];
    
}

- (void)draggingWithPan:(UIPanGestureRecognizer *)pan{
    
    //获取手指的位移
    CGFloat offsetX = [pan translationInView:self.view].x;
    //整个view平移
    if (offsetX > 0) {
        self.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    }
    
    CGFloat currentTranslateScale = offsetX / KSCREEN_WIDTH;
    if (offsetX < KSCREEN_WIDTH) {
        
//        _screenshotImgView.transform = CGAffineTransformMakeTranslation((offsetX - KSCREEN_WIDTH) * 0.6, 0);
        
        _screenshotImgView.layer.transform = CATransform3DMakeScale(0.96 - currentTranslateScale * 0.3, 0.98 - currentTranslateScale * 0.3, 0.98 - currentTranslateScale * 0.3);
    }
    
    //根据偏移量计算透明度
    CGFloat currentAlpha = 0.3 - currentTranslateScale * 0.3;
    _coverView.alpha = currentAlpha;
}

- (void)endDrag{
    
    CGFloat translateX = self.view.transform.tx;
    if (translateX <= KSCREEN_WIDTH / 2 - 60) {
        
        //弹回
        [UIView animateWithDuration:0.3 animations:^{
            
            self.view.transform = CGAffineTransformIdentity;
            //恢复imagView的位置
//            _screenshotImgView.transform = CGAffineTransformMakeTranslation(-KSCREEN_WIDTH, 0);
        } completion:^(BOOL finished) {
            
            [_screenshotImgView removeFromSuperview];
            [_coverView removeFromSuperview];
        }];
    }
    else{
        
        //pop成功
        [UIView animateWithDuration:0.3 animations:^{
           
            self.view.transform = CGAffineTransformMakeTranslation(KSCREEN_WIDTH, 0);
            _screenshotImgView.transform = CGAffineTransformMakeTranslation(0, 0);
            
        } completion:^(BOOL finished) {
            
            self.view.transform = CGAffineTransformIdentity;
            [_screenshotImgView removeFromSuperview];
            [_coverView removeFromSuperview];
            [self popViewControllerAnimated:NO];
        }];
    }
}

//截图
- (void)screenShot{
    
    UIViewController *currentVC = self.view.window.rootViewController;
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(currentVC.view.frame.size, YES, 0.0);
    CGRect rect = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
    [currentVC.view drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    //从上下文中，取出image
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    //添加截取好的图片到数组
    if (snapshot) {
        
        [_screenshotImgArray addObject:snapshot];
    }
    //结束上下文
    UIGraphicsEndImageContext();
}

#pragma mark - navigation delegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    

    if (self.viewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"back"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //让返回按钮内容继续向左边偏移15，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        btn.frame = CGRectMake(0, 0, 40, 40);
        UIView *backBtnView = [[UIView alloc] initWithFrame:btn.bounds];
        [backBtnView addSubview:btn];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
        viewController.navigationItem.hidesBackButton = YES;
        
//        [self createGesture];
//        //截图
//        [self screenShot];
    }
    
    [super pushViewController:viewController animated:animated];
}

// Override pop
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    [_screenshotImgArray removeLastObject];
    return [super popViewControllerAnimated:animated];
}

- (void)backBtnAction{
    
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

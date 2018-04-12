//
//  HYGuideViewController.m
//  DaCongMing
//
//

#import "HYGuideViewController.h"

@interface HYGuideViewController () <UIScrollViewDelegate>

/** 轮播图 */
@property (nonatomic,strong) UIScrollView  *scrollView;
/** 启动页 */
@property (nonatomic,strong) NSArray *guideArray;
/** 跳过btn */
@property (nonatomic,strong) UIButton *skipBtn;
/** pageControl */
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation HYGuideViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    //@[@"guide1",@"guide2",@"guide3"];
    self.guideArray = @[@"jguide1",@"jguide2",@"guide3"];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
//    [self.view addSubview:self.skipBtn];

    for (NSInteger i = 0; i < self.guideArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed: self.guideArray[i]];
        imageView.frame = CGRectMake(i * KSCREEN_WIDTH, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT);
        [self.scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        if (i == 2) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor clearColor];
            btn.layer.borderColor = KAPP_WHITE_COLOR.CGColor;
            btn.layer.borderWidth = 1;
            btn.layer.cornerRadius = 4 * WIDTH_MULTIPLE;
            [btn setTitle:@"进入大聪明" forState:UIControlStateNormal];
            [btn setTitleColor:KAPP_THEME_COLOR forState:UIControlStateNormal];
            [btn.titleLabel setFont:KFont(18)];
            [imageView addSubview:btn];
            [btn addTarget:self action:@selector(skipBtnAction) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view layoutIfNeeded];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.equalTo(self.view).offset(-36 * WIDTH_MULTIPLE);
                make.centerX.equalTo(imageView);
                make.size.mas_equalTo(CGSizeMake(160 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE));
            }];
            
            UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(skipBtnAction)];
            leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
            [imageView addGestureRecognizer:leftSwipe];
            
        }
    }
}

- (void)viewWillLayoutSubviews{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.view).offset(-36 * WIDTH_MULTIPLE);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(160 * WIDTH_MULTIPLE, 50 * WIDTH_MULTIPLE));
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20 * WIDTH_MULTIPLE);
        make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH, 60 * WIDTH_MULTIPLE));
    }];
}

- (void)skipBtnAction{
    
    [HYUserHandle jumpToHomePageVC];
}

#pragma mark - scrollDelete
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 设置页码
    _pageControl.currentPage = page;
    
    if (page == 2) {
        
        self.pageControl.hidden = YES;
    }
    else{
        self.pageControl.hidden = NO;
    }
}

#pragma mark - lazyload
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(KSCREEN_WIDTH * 3, KSCREEN_HEIGHT);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIButton *)skipBtn{
    
    if (!_skipBtn) {
        
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.backgroundColor = [UIColor clearColor];
        [_skipBtn addTarget:self action:@selector(skipBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;//指定页面个数
        //指定pagecontroll的值，默认选中的小白点（第一个）
         _pageControl.currentPage = 0;
        //添加委托方法，当点击小白点就执行此方法
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];// 设置非选中页的圆点颜色
        _pageControl.currentPageIndicatorTintColor = KAPP_THEME_COLOR; // 设置选中页的圆点颜色
    }
    return _pageControl;
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

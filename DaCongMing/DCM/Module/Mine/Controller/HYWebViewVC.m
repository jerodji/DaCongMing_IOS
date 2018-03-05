//
//  HYWebViewVC.m
//  DaCongMing
//
//

#import "HYWebViewVC.h"
#import <WebKit/WebKit.h>
#import "HYShareView.h"


@interface HYWebViewVC ()<WKUIDelegate,WKNavigationDelegate>

//   WKUIDelegate                   JS代码里有弹框等事件的时候相关的
//   WKScriptMessageHandler         JS代码需要调用原生的方法的时候相关

/**WKWebView*/
@property (nonatomic,strong) WKWebView *webView;

/**progress*/
@property (nonatomic,strong) UIProgressView *progressView;

/** share */
@property (nonatomic,strong) HYShareView *shareView;
/* 分享的标题 */
@property (nonatomic,copy) NSString * shareTitle;
@end

@implementation HYWebViewVC

- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (NSMutableDictionary*)analyzeURL:(NSString*)urlstr
{
    //tempDic中存放一个URL中转换的键值对
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    
    //获取问号的位置，问号后是参数列表
    NSRange range = [urlstr rangeOfString:@"?"];
    NSString* URL = [urlstr substringToIndex:range.location];
    [tempDic setObject:URL forKey:@"url"];
//    NSLog(@"参数列表开始的位置：%d", (int)range.location);
    
    //获取参数列表
    NSString *propertys = [urlstr substringFromIndex:(int)(range.location+1)];
//    NSLog(@"截取的参数列表：%@", propertys);
    
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
//    NSLog(@"把每个参数列表进行拆分，返回为数组：\n%@", subArray);
    
    //把subArray转换为字典
    for (int j = 0 ; j < subArray.count; j++) {
        //在通过=拆分键和值
        NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
//        NSLog(@"再把每个参数通过=号进行拆分：\n%@", dicArray);
        //给字典加入元素
        [tempDic setObject:dicArray[1] forKey:dicArray[0]];
    }
    NSLog(@"打印参数列表生成的字典：\n%@", tempDic);
    return tempDic;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (NotNull(self.params)) {
        NSLog(@"%@",self.params);
        NSDictionary*dic = [self analyzeURL:self.params[@"urlStr"]];
        if (NotNull([dic objectForKey:@"url"])) {
            self.url = [dic objectForKey:@"url"];
        }
        if (NotNull([dic objectForKey:@"img"])) {
            self.img = [dic objectForKey:@"img"];
        }
        if (NotNull([dic objectForKey:@"shareUrl"])) {
            self.shareUrl = [dic objectForKey:@"shareUrl"];
        }
        if (NotNull([dic objectForKey:@"descriptions"])) {
            self.descriptions = [NSString stringWithFormat:@"%@",[dic objectForKey:@"descriptions"]].stringByRemovingPercentEncoding;
        }
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareHealthInfoAction)];
    
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [MBProgressHUD showPregressHUDWithLoadingText:@"正在加载中！"];
}

- (void)shareHealthInfoAction {
    [KEYWINDOW addSubview:self.shareView];
    [self.shareView showShareView];
    
    HYShareModel *model = [[HYShareModel alloc] init];
    model.shareType = HYShareTypeWebUrl;
    model.shareWebUrl = self.shareUrl;
    model.shareTitle = self.shareTitle;
    model.urlImg = self.img;
    model.shareDescription = self.descriptions;
    self.shareView.shareModel = model;
}

- (HYShareView *)shareView{
    if (!_shareView) {
        _shareView = [[HYShareView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    }
    return _shareView;
}

#pragma mark ********监听加载进度********
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == self.webView &&  [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        NSLog(@"%f",newProgress);
        if (newProgress == 1) {
            self.progressView.hidden = YES;
        }
        else{
            self.progressView.hidden = NO;
            self.progressView.progress = newProgress;
            
            [MBProgressHUD hidePregressHUD:KEYWINDOW];
        }
    }
}

#pragma mark ********webView代理********
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        self.shareTitle = result;
//        self.title = result;
    }];
    
    //    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //    context[@"Native"] = self;
    //    context[@"callback"] = ^{
    //        NSArray *args = [JSContext currentArguments];
    //        NSLog(@"%@",args);
    //    };
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"%@",error);
}


#pragma mark - lazyload
- (WKWebView *)webView{
    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNAV_HEIGHT)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
        
        //        //创建WKWebView的配置对象
        //        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        //        //设置configuration对象的preferences属性的信息
        //        WKPreferences *preference = [[WKPreferences alloc] init];
        //        configuration.preferences = preference;
        //        //是否允许与JS交互，默认YES
        //        preference.javaScriptEnabled = YES;
        //        //通过JS与WebView内容交互
        //        configuration.userContentController = [[WKUserContentController alloc] init];
        //        [configuration.userContentController addScriptMessageHandler:self name:@"callback"];
        
    }
    return _webView;
}

- (UIProgressView *)progressView{
    
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 20 * WIDTH_MULTIPLE)];
        _progressView.backgroundColor = KAPP_b7b7b7_COLOR;
        _progressView.progress = 0;
        _progressView.progressTintColor = KAPP_THEME_COLOR;
    }
    return _progressView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

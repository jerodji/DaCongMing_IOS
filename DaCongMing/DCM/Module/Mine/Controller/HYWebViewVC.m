//
//  HYWebViewVC.m
//  DaCongMing
//
//  Created by 胡勇 on 2017/10/26.
//  Copyright © 2017年 胡勇. All rights reserved.
//

#import "HYWebViewVC.h"
#import <WebKit/WebKit.h>


@interface HYWebViewVC ()<WKUIDelegate,WKNavigationDelegate>

//   WKUIDelegate                   JS代码里有弹框等事件的时候相关的
//   WKScriptMessageHandler         JS代码需要调用原生的方法的时候相关

/**WKWebView*/
@property (nonatomic,strong) WKWebView *webView;

/**progress*/
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation HYWebViewVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [MBProgressHUD showPregressHUDWithLoadingText:@"正在加载中！"];
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
        
        self.title = result;
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
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
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

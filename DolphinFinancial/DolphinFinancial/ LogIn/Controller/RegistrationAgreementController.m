//
//  RegistrationAgreementController.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/5/17.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "RegistrationAgreementController.h"

#import <WebKit/WebKit.h>

@interface RegistrationAgreementController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation RegistrationAgreementController

+ (void)pushToController:(UINavigationController *)navigationController
{
    if (navigationController == nil) {
        return;
    }
    RegistrationAgreementController *mdvc = [[RegistrationAgreementController alloc] init];
    [navigationController pushViewController:mdvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://103.71.236.209:8801/registration-protocol.html"]]];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addKVOToWebView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeObserverToWebView];
}

#pragma mark - getter
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
    }
    return _webView;
}
- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.progressTintColor = DFTINTCOLOR;
        [self.view addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        }];
    }
    return _progressView;
}

- (void)makeView
{
    [self addLeftBackButton];
    [self setCenterTitle:@"注册协议"];
    
    [self.view addSubview:self.webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ownNavigationBar.mas_bottom);
        make.left.and.bottom.and.right.mas_equalTo(self.view);
    }];
}
#pragma mark - webView KVO title 和 进度
- (void)addKVOToWebView
{
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}
- (void)removeObserverToWebView
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"estimatedProgress"] && object == self.webView){
        [self.progressView setProgress:self.webView.estimatedProgress];
        self.progressView.hidden = self.webView.estimatedProgress == 1;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - wkwebView delegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"********************%@",NSStringFromSelector(_cmd));
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"********************%@",NSStringFromSelector(_cmd));
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"********************%@",NSStringFromSelector(_cmd));
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"********************%@",NSStringFromSelector(_cmd));
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(nonnull NSURLAuthenticationChallenge *)challenge completionHandler:(nonnull void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        
    }
}


@end

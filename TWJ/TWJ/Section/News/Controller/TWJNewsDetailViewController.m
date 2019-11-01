//
//  TWJNewsDetailViewController.m
//  TWJ
//
//  Created by ydd on 2019/9/10.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJNewsDetailViewController.h"

@interface TWJNewsDetailViewController ()
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation TWJNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
}

- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] init];
//        _webView.delegate = self;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _webView;
}


@end

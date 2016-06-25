//
//  TinyViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/23.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "TinyViewController.h"
#import <WebKit/WebKit.h>
@interface TinyViewController ()
@property(nonatomic,strong)WKWebView *web;
@end

@implementation TinyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url=[NSURL URLWithString:@"http://weibo.com/u/2852517300?is_hot=1"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.web loadRequest:request];
    UIView * vc=[[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *progress=[MBProgressHUD showHUDAddedTo:vc animated:YES];
    [progress hide:YES afterDelay:3];
}
#pragma mark-懒加载
-(WKWebView *)web{
    if (!_web) {
        _web=[[WKWebView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_web];
        [_web mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _web;

}

@end

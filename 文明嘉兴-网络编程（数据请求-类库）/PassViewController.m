//
//  PassViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC010 on 16/6/23.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "PassViewController.h"
#import <WebKit/WebKit.h>
@interface PassViewController (){
    int i;
}
- (IBAction)ReturnViewController:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property(nonatomic,strong)WKWebView *webView;
@end

@implementation PassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.webView];
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSArray *array=[defaults valueForKeyPath:@"value"];
    NSArray * arr=@[@"http://www.cnjxol.com/index.htm",@"http://jx.wenming.cn/",@"http://www.zjw",@"http://www.zjol.com.cn/",@"http://www.cncn.org.cn/",@"http://www.kids21.cn/",@"http://www.hcyjw.cn/",@"http://nhnews.zjol.com.cn/nhnews/nhwm/",@"http://jxxznews.zjol.com.cn/",@"heep://news.163.com/10/0420/17/64NT2Uf100014aed.html",@"http://wmw.tx.gov.cn/web/",@"http://zjhn.wenming.cn/",@"http://gfjy.jiaxing.gov.cn/",@"http://www.cnjxol.com/topic/qzlx/",@"http://www.nhyouth.gov.cn"];
    i=[array[0] intValue];
    self.titleLable.text=array[1];
    NSURL * url=[NSURL URLWithString:arr[i]];
    NSURLRequest * quest =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:quest];
}
#pragma mark 跳回原页面
- (IBAction)ReturnViewController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

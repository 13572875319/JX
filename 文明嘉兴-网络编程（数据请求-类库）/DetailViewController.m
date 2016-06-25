//
//  DetailViewController.m
//  04-News
//
//  Created by 大鹏 on 16/6/22.
//  Copyright © 2016年 dongchen. All rights reserved.
//

#import "DetailViewController.h"
#import "News.h"

@interface DetailViewController ()<UIWebViewDelegate>
{
    MBProgressHUD *HUD;
    UIView *vLoging;//覆盖屏幕
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *svContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFrom;

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeght;


@end

@implementation DetailViewController


#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    //拦截网页中的图片  并修改图片大小
    [self.webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=450;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = 300;"
     "myimg.height = 200;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    //执行一段JavaScript代码
    [self.webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //获取HTML内容的高度
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    frame.size.height = height+10;
    
    self.webView.frame = frame;
    
    //修改托线约束，因为高度不固定，故托线后进行修改
    self.webViewHeght.constant = frame.origin.y+height+10;
    //设置滚动视图的ContentSize
    self.svContent.contentSize = CGSizeMake(320, frame.origin.y+height+10);
    [self.view layoutIfNeeded];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    vLoging = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
    vLoging.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vLoging];
    self.webView.delegate = self;
    self.webView.userInteractionEnabled = YES;
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    //接口只支持POST
    [self.manager POST:HTTP_getNewsDetailById
            parameters:self.params
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if ([responseObject[@"result"] isEqualToNumber:@0]) {
                       NSDictionary *data = responseObject[@"data"];
                       News *news = [News mj_objectWithKeyValues:data];
                       self.lblTitle.text = news.title;
                       self.lblFrom.text = [@"发布日期:" stringByAppendingFormat:@"%@         来源:%@",news.issuestime,news.source];
        
                       self.lblFrom.adjustsFontSizeToFitWidth = YES;
                       [self.webView loadHTMLString:news.content baseURL:nil];
                       [vLoging removeFromSuperview];
                       [HUD hide:NO];
                   }else{
                       NSLog(@"请求错误：%@",responseObject[@"message"]);
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"出错了:%@",error);
               }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (AFHTTPSessionManager *)manager
{
    if (_manager) {
        return _manager;
    }
    _manager = [AFHTTPSessionManager manager];
    //请求的时候要使用JSON数据序列化
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return _manager;
}


@end

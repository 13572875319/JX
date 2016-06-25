//
//  ShareViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC010 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "ShareViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface ShareViewController ()
- (IBAction)share:(UIButton *)sender;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)share:(UIButton *)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容测试"
                                       defaultContent:@"默认分享内容测试，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"pmmq"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败");
                                }
                            }];
}
@end

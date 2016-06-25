//
//  CivilizationViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/15.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "CivilizationViewController.h"
#import "ShareViewController.h"
#import "QRcodeViewController.h"
#import "FriendshipViewController.h"
#import "NotificationViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface CivilizationViewController ()<YSLContainerViewControllerDelegate>

@end

@implementation CivilizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array=@[@"二维码",@"通知公告",@"友情链接",@"分享好友"];
    
    ShareViewController* share=[self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
    share.title=array[3];
    QRcodeViewController* QRCode=[[QRcodeViewController alloc]init];
    QRCode.title=array[0];
    FriendshipViewController* friend=[[FriendshipViewController alloc]init];
    friend.title=array[2];
   NotificationViewController* notification=[[NotificationViewController alloc]init];
    notification.title=array[1];
    YSLContainerViewController * container=[[YSLContainerViewController alloc]initWithControllers:@[QRCode,notification,friend,share] topBarHeight:25 parentViewController:self];
    [self.view addSubview:container.view];
    container.menuBackGroudColor=[UIColor redColor];
    container.menuItemSelectedTitleColor=[UIColor redColor];    
    container.delegate=self;

}
#pragma mark YSLContainerViewController类库的代理方法
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller{
    if (index ==3) {
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
    
}
@end

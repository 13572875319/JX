//
//  NewViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/15.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "NewViewController.h"
#import "OneController.h"
#import "NewsSort.h"
@interface NewViewController ()<YSLContainerViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray *categoryArr;
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //发送一个通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNewsSortManager:) name:GetNewsCategoryNotification object:nil];
    //请求新闻分类
    [NewsSort getNewsSort];
}
#pragma mark-获取新闻分类的通知回调方法,将数组中的分类名称给数组categoryArr
-(void)getNewsSortManager:(NSNotification *)notification{
    
    if ([notification.object isKindOfClass:[NSArray class]]) {
        for (NewsSort *obj in notification.object) {
            [self.categoryArr addObject:obj.categoryName];
        }
    }
    //实例化8个控制器
    NSMutableArray <UIViewController *>*controllerArr=[NSMutableArray array];
    for (int i=0; i<self.categoryArr.count-1; i++) {
        OneController *one=[self.storyboard instantiateViewControllerWithIdentifier:@"OneController"];
        one.title=self.categoryArr[i];
        [controllerArr addObject:one];
    }
    //实现分段控制的类库
    YSLContainerViewController *controller=[[YSLContainerViewController alloc]initWithControllers:controllerArr topBarHeight:30 parentViewController:self];
    controller.delegate=self;
    [self.view addSubview:controller.view];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    [controller viewWillAppear:YES];
}
#pragma categoryArr进行懒加载
-(NSMutableArray *)categoryArr{
    if (!_categoryArr) {
        _categoryArr=[NSMutableArray array];
    }
    return _categoryArr;
}

@end

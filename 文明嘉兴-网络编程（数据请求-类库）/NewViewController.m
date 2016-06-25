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
    self.tabBarController.tabBar.tintColor = [UIColor orangeColor];
    //修改tabBarItem的字体颜色
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
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
    YSLContainerViewController *controller=[[YSLContainerViewController alloc]initWithControllers:controllerArr topBarHeight:22 parentViewController:self];
    controller.menuBackGroudColor=[UIColor orangeColor];
    controller.menuItemSelectedTitleColor=[UIColor redColor];
    controller.delegate=self;
    [self.view addSubview:controller.view];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(OneController *)controller
{
    [controller setPageParameter:(int)index+1];
}
#pragma mark categoryArr进行懒加载
-(NSMutableArray *)categoryArr{
    if (!_categoryArr) {
        _categoryArr=[NSMutableArray array];
    }
    return _categoryArr;
}

#pragma mark 移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:GetNewsCategoryNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

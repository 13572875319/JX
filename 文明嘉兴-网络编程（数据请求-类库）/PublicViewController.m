//
//  PublicViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/15.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "PublicViewController.h"
#import "GetPsas.h"
@interface PublicViewController (){
    float hight;
}
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加一个通知
    [[ NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetPsasMangerNotification:) name:GetPsasNotification object:nil];
    //获取网络请求数据
    [GetPsas getPsasManager];
}
#pragma mark -GetPsasMangerNotification回调函数
-(void)GetPsasMangerNotification:(NSNotification*)notification{
    //判断notification.object是否为数组
    if ([notification.object isKindOfClass:[NSArray class]]) {
        //将数据添加到相应的数组中
        for (GetPsas *obj in notification.object) {
            [self.titleArray addObject:obj.title];
            [self.imageArray addObject:obj.imageurl];
        }
    }
    //实例化无限轮播
    SDCycleScrollView *cycle=[SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:self.imageArray];
    cycle.titlesGroup=self.titleArray;
    cycle.titleLabelHeight=50;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [cycle sizeToFit];
    [self.view addSubview:cycle];
    [cycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 50, 0));
    }];
}
#pragma set-数组的懒加载
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray=[NSMutableArray array];
    }
    return _titleArray;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray=[NSMutableArray array];
    }
    return _imageArray;
}
#pragma mark-移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:GetPsasNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

//
//  ViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/4.
//  Copyright © 2016年 段东刚. All rights reserved.
//  思路 思路各自实现各自的内容网络请求完成时可以给数据 表格创建可提前创建
//

#import "OneController.h"
#import "DetailViewController.h"
#import "ThemeTableViewCell.h"
@interface OneController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>{
    int pageNum;
    int page;//分类iD
    int normalHight;//共同
    int otherHight;//cell的高度只适应（第7个）
}
@property(nonatomic ,strong)NSMutableArray <News *>*newsArr;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *bannerArr;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end

@implementation OneController
- (void)viewDidLoad {
    [super viewDidLoad];
    pageNum=1;
    page=1;
    //创建tableView
    [self creatTableView];
    //创建无限轮播SDCycleScrollView
    [self creatScrollView];
    //网络状态显示（可选）
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    //添加通知，当获取到数据是进行提示
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleNotificationByNews:)
     name:GetNewsDataNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(bannerNotification:)
     name:GetBannerDataNotification
     object:nil];
}
#pragma mark-banner的通知的回调方法并将通知传递的参数给对应的数组
-(void)bannerNotification:(NSNotification *)notification{
        //判断这个object是不是数组
    if ([notification.object isKindOfClass:[NSArray class]]) {
        //给数组赋值
        self.bannerArr=notification.object;
    }
    NSArray *lableGroup=[self.bannerArr valueForKey:@"title"];
    NSArray *imagerGroup=[self.bannerArr valueForKey:@"imageurl"];
    //对无限轮播的图片数组赋值
    self.cycleScrollView.imageURLStringsGroup=imagerGroup;
    //对无限轮播的文字数组赋值
    self.cycleScrollView.titlesGroup=lableGroup;
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}
#pragma mark - 新闻列表的通知回调方法
- (void) handleNotificationByNews:(NSNotification *)notification
{
    //判断是否第一页
    if (pageNum == 1) {
        self.newsArr = [NSMutableArray array];
    }
    //判断这个object是不是数组
    if ([notification.object isKindOfClass:[NSArray class]]) {
        //往数组中追加，这个一般用户上拉时会调用
        [self.newsArr addObjectsFromArray:notification.object];
    }
    //设置tableView的数据源两个方法 1、返回的行 2、绘制cell
    self.tableView.dataSource=self;
    //停止头部刷新
    [self.tableView.mj_header endRefreshing];
    //停止脚步刷新
    [self.tableView.mj_footer endRefreshing];
    //给数据进行更新
    [self.tableView  reloadData];
    //请求banner数据
    [BannerNews receiveBannerManager:page];
}

#pragma mark - 实现tableViewDataSource的方法
#pragma mark 返回的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArr.count;
}
#pragma mark 绘制cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (page==7) {
        ThemeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newCell"];
        //设置图片
        [cell.image setImageWithURL:[NSURL URLWithString:self.newsArr[indexPath.row].image] placeholderImage:[UIImage imageNamed:@"265.jpg"]];
        //--------截取时间段----------
        NSString *time=self.newsArr[indexPath.row].issuestime;
        NSRange range = {5,time.length-5};
        //显示时间
        cell.timeLable.text=[time substringWithRange:range];
        //显示标题
        cell.titleLable.text=self.newsArr[indexPath.row].title;
        //自适应
        [cell sizeToFit];
        //返回的高度
        otherHight=cell.image.frame.size.height+cell.titleLable.frame.size.height+10;
        return cell;
    }else{
        //服用队列
        TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        //设置title
        cell.title.text=self.newsArr[indexPath.row].title;
        //设置新闻简介
        cell.summary.text=self.newsArr[indexPath.row].summary;
        //设置图片
        [cell.image setImageWithURL:[NSURL URLWithString:self.newsArr[indexPath.row].image] placeholderImage:[UIImage imageNamed:@"265.jpg"]];
        //设置点赞数
        cell.praiseNum.text=[NSString stringWithFormat:@"赞 %@",self.newsArr[indexPath.row].praiseNum];
        //设置浏览数量
        cell.browseNum.text=[NSString stringWithFormat:@"浏览 %@",self.newsArr[indexPath.row].browseNum];
        //设置发布时间
        cell.issuestime.text=self.newsArr[indexPath.row].issuestime;
        [cell sizeToFit];
        normalHight=cell.image.frame.size.height+10;
        return cell;
    }
   
}
#pragma mark -创建表视图及上下拉刷新对象
-(void)creatTableView{
    //设置tableView的frame
    self.tableView =[[UITableView alloc]init];
    //将tableView添加到View上
    [self.view addSubview:self.tableView];
    //添加约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    //设置代理方式
    self.tableView.delegate=self;
    //设置tableView的注册
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[ThemeTableViewCell class] forCellReuseIdentifier:@"newCell"];
    //设置tableView的行高
    self.tableView .rowHeight=101;
    //--------1.下拉刷新动画 ----------
    //创建上下拉刷新数据
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        [News receiveDataWithPageNum:pageNum andCategoryPage:page];
    }];
    NSMutableArray *array=[NSMutableArray array];
    for (int i=1; i<41; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i",i]]];
    }
    [header setImages:array forState:MJRefreshStatePulling];
    //设置头部刷新
    self.tableView.mj_header=header;
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
    //--------上拉刷新----------
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [News receiveDataWithPageNum:++pageNum andCategoryPage:page];
    }];

}
#pragma mark -创建无限轮播并将其添加到表视图的头部
- (void)creatScrollView
{
    //--------实例化SDCycle----------
   self.cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 375, 200) delegate:self placeholderImage:[UIImage imageNamed:@"265.jpg"]];
    self.cycleScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleAnimated;
    self.cycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
    //将SDCycle对象添加到表示头头部
    self.tableView.tableHeaderView  = _cycleScrollView;
}
#pragma mark - 选中某一行时进行跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取数据
    News *new=self.newsArr[indexPath.row];
    DetailViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    //根据文档得到计算公式，最后的-1取消，因为row就是从0开始的
    [detail setParams:@{
                        @"newsId":new.newsId,
                        @"categoryFk":@(page),
                        @"pageNum":@(indexPath.row)
                        }];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark-设置CategoryId的参数
-(void)setPageParameter:(int)pageNumber{
    page=pageNumber;
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark-tableViewCell的高度自适应
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (page==7) {
        return otherHight;
    }else{
        return normalHight;
    }
}
#pragma  mark- 释放通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:GetNewsDataNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:GetBannerDataNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

//
//  NotificationViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC010 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationTableViewCell.h"
#import "GetAnnouncement.h"
@interface NotificationViewController()<UITableViewDataSource,UITableViewDelegate>{
    int hight;

}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic ,strong)NSArray * array;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAnnounceNotification:) name:GetAnnouncementNotification object:nil];
    [GetAnnouncement getcAnnouncementManager];
}
#pragma mark-getAnnounceNotification的回调函数
-(void)getAnnounceNotification:(NSNotification *)notification{
    if ([notification.object isKindOfClass:[NSArray class]]) {
        self.array=notification.object;
        [self creatTableView];
    }

}
#pragma mark-绘制tableView
-(void)creatTableView{
    //设置tableView的frame
    self.tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    //将tableView添加到View上
    [self.view addSubview:self.tableView];
    //添加约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.tableView registerClass:[NotificationTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight=130;
}
#pragma mark-TableViewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    GetAnnouncement *new=self.array[indexPath.row];
    cell.titleLable.text=new.title;
    cell.detailLable.text=new.content;
    cell.timeLable.text=new.createTimeStr;
    [cell sizeToFit];
    return cell;
}


@end

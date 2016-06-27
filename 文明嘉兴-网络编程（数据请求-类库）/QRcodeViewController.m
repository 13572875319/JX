//
//  OneViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC010 on 16/6/23.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "QRcodeViewController.h"

@interface QRcodeViewController ()
@property (nonatomic ,strong)UILabel * label1;
@property (nonatomic ,strong)UIImageView * imageView;
@property (nonatomic ,strong)UILabel * label2;
@end

@implementation QRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //label1
    self.label1=[[UILabel alloc]init];
    [self.view addSubview:self.label1];
    self.label1.text=@"扫一扫";
    self.label1.font=[UIFont systemFontOfSize:30];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(5);
        
    }];
    //imageView
    self.imageView=[[UIImageView alloc]init];
    [self.view addSubview:self.imageView];
    self.imageView.image=[UIImage imageNamed:@"二位码.jpg"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.top.equalTo(self.view).offset(60);
        make.centerX.equalTo(self.view);
    }];
    //label2
    self.label2=[[UILabel alloc]init];
    [self.view addSubview:self.label2];
    self.label2.text=@"关注嘉兴文明网官方微信，更多精彩新闻，为你呈现";
    self.label2.numberOfLines=2;
    self.label2.font=[UIFont systemFontOfSize:18];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(240, 50));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(280);
    }];

    
}




@end

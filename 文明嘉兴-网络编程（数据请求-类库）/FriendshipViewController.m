//
//  FriendshipViewController.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC010 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "FriendshipViewController.h"
#import "FriendshipCollectionViewCell.h"
#import "PassViewController.h"
@interface FriendshipViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic ,strong)NSArray * arrayI;
@property (nonatomic ,strong)NSArray * arrayII;
@property(nonatomic ,strong)NSArray * arrayIII;
@end

@implementation FriendshipViewController
int k;
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc]init];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [_collectionView registerClass:[FriendshipCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.arrayI=@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15"];
    self.arrayII=@[@"嘉兴文明网联盟",@"浙江文明网",@"嘉兴在线",@"浙江在线",@"中国社区网",@"金华为成人网",@"红船网",@"南湖文明网",@"秀洲文明网",@"星期六义务劳动联盟",@"桐乡文明网",@"海宁文明网",@"嘉兴国防教育网",@"嘉兴群众路线网",@"南湖青少年网",];
    self.arrayIII=@[@"jiaxian civilization network alliance",@"zhejiang civilzation network",@"jiaxing online",@"zhejiang online",@"The Chinese community",@"jinhua minor remarks",@"The red ship network",@"South lake minor remaks",@"Show chau civilization network",@"Compulsory labor union on Staturday",@"Tongxiang city civilization network",@"Haining civilization network",@"jiaxing defense education netwrok",@"jiaxing defense education network",@"South lake youth network"];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayI.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FriendshipCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.label1.text=self.arrayI[indexPath.row];
    cell.label2.text=self.arrayII[indexPath.row];
    cell.label3.text=self.arrayIII[indexPath.row];
    [cell.layer setMasksToBounds:YES];
    //设置边框圆角的弧度 
    [cell.layer setCornerRadius:15.0];
    //设置边框线的宽
    [cell.layer setBorderWidth:1.5];
    //设置边框线的颜色
    [cell.layer setBorderColor:[[UIColor blackColor] CGColor]];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(145, 130);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 30, 0, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string=[NSString stringWithFormat:@"%li",indexPath.row];
    NSString *title=self.arrayII[indexPath.row];
    NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
    [user setValue:@[string,title] forKey:@"value"];
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PassViewController *pass=[story instantiateViewControllerWithIdentifier:@"PassViewController"];
    [self presentViewController:pass animated:YES completion:nil];
}

@end

//
//  BannerNews.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/12.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "BannerNews.h"
#import "MBProgressHUD.h"
@implementation BannerNews
+(void)receiveBannerManager{
    [[[self class]alloc] getbannerDate];
}
#pragma mark - 获取banner数据成立时，对无线轮播数据进行加载
-(void)getbannerDate{
    //获取MBProgress的View目标所在
    UIView *view=[[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *test=[MBProgressHUD showHUDAddedTo:view animated:YES];
    //定义一个字典
    NSDictionary *dictBanner=@{@"categoryId":@1};
    //增加 实例化一个可变的无序数组，并将responseSerializer.acceptableContentTypes添加到数组中
    NSMutableSet *set=[NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    //给数组添加元素 text/html
    [set addObject:@"text/html"];
    //将可变的无序数组有赋值个responseSerializer.acceptableContentTypes
    self.manager.responseSerializer.acceptableContentTypes=set;
    //发送请求
    [self.manager POST:getBanner parameters:dictBanner progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //响应对象为字典（判断响应对象的键result对应的值是否是0成功则执行条件体）
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //暂停MBProgress
            [test hide:YES];
            //将请求的数据给数组
            NSArray *array=responseObject[@"data"];
            //将字典的数组转换为模型数组
            NSArray *resultNews= [BannerNews mj_objectArrayWithKeyValuesArray:array];
            //执行通知Post方法
            [[NSNotificationCenter defaultCenter]postNotificationName:GetBannerDataNotification object:resultNews];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //设置模式为现在文字
        test.mode=MBProgressHUDModeText;
        //设置文字内容
        test.labelText=@"网络请求失败,请检测网络设置";
        //暂停
        [test hide:YES];
        NSLog(@"请求错误：%@",error);
    }];
}
#pragma mark 重新manger方法
- (AFHTTPSessionManager *)manager
{
    //如果有对象就返回没有就创建
    if (_manager) {
        return  _manager;
    }
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return _manager;
}
@end

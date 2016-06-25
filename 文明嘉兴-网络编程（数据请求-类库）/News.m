//
//  News.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/8.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "News.h"
#import "MBProgressHUD.h"
@implementation News

+(void)receiveDataWithPageNum:(int)pageNum andCategoryPage:(int)page{
    [[[self class]alloc] receiveDataWithPageNum:pageNum andCategoryPage:page];
}
#pragma mark 获取数据的方法
-(void)receiveDataWithPageNum:(int)pageNum andCategoryPage:(int)page{
    //获取MBProgress的View目标所在
    UIView *view=[[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *progress=[MBProgressHUD showHUDAddedTo:view animated:YES];
    //增加 实例化一个可变的无序数组，并将responseSerializer.acceptableContentTypes添加到数组中
    NSMutableSet *set=[NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    //给数组添加元素 text/html
    [set addObject:@"text/html"];
    //将可变的无序数组有赋值个responseSerializer.acceptableContentTypes
    self.manager.responseSerializer.acceptableContentTypes=set;
    //实例化字典作为POST的请求boby
    NSDictionary *dict=@{
                         @"categoryId":@(page),
                         @"pageNum":@(pageNum)
                         };
    
    //发送请求
    [self.manager POST:getNews parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //响应对象为字典（判断响应对象的键result对应的值是否是0成功则执行条件体）
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //定义一个中间数组temp
            NSArray *temp=responseObject[@"data"];
            NSArray *resultNews= [News mj_objectArrayWithKeyValuesArray:temp];
            //发送通知，已经加载到了数据
            [[NSNotificationCenter defaultCenter] postNotificationName:GetNewsDataNotification object:resultNews];
            [progress hide:YES];
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //设置模式为现在文字
        progress.mode=MBProgressHUDModeText;
        //设置文字内容
        progress.labelText=@"网络请求失败,请检测网络设置";
        //暂停
        NSLog(@"网络请求失败：%@",error);
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

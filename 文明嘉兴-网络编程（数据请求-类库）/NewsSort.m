//
//  NewsSort.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "NewsSort.h"

@implementation NewsSort
+(void)getNewsSort{
    [[[self class] alloc] getNewsSort];
}
#pragma mark 获取新闻分类请求
-(void)getNewsSort{
    //增加 实例化一个可变的无序数组，并将responseSerializer.acceptableContentTypes添加到数组中
    NSMutableSet *set=[NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    //给数组添加元素 text/html
    [set addObject:@"text/html"];
    //将可变的无序数组有赋值个responseSerializer.acceptableContentTypes
    self.manager.responseSerializer.acceptableContentTypes=set;
    [self.manager POST:getNewsCategory parameters:nil progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if ([responseObject[@"result"] isEqualToNumber:@0]) {
                       //通过一个中间变量获取Json数据
                       NSArray *temp=responseObject[@"data"];
                       //将其转换为模型
                       NSArray *resultNews= [NewsSort mj_objectArrayWithKeyValuesArray:temp];
                       //发送通知数据请求完成
                       [[NSNotificationCenter defaultCenter]postNotificationName:GetNewsCategoryNotification object:resultNews];
                   }
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"%@",error);
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
//    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    return _manager;
}
@end

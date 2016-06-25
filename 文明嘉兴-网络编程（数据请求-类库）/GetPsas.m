//
//  GetPsas.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/23.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "GetPsas.h"

@implementation GetPsas
+(void)getPsasManager{
    [[[self class] alloc] getPsasManager];
}
-(void)getPsasManager{
    [self.manager POST:HTTP_getPsas parameters:nil progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   if ([responseObject[@"result"] isEqualToNumber:@0]) {
                       //通过一个中间变量获取Json数据
                       NSArray *temp=responseObject[@"data"];
                       //将其转换为模型
                       NSArray *resultNews= [GetPsas mj_objectArrayWithKeyValuesArray:temp];
                       //发送通知数据请求完成
                       [[NSNotificationCenter defaultCenter]postNotificationName:GetPsasNotification  object:resultNews];
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
    return _manager;
}
@end

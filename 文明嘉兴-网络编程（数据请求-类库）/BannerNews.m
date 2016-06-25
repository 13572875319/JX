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
+(void)receiveBannerManager:(int)page{
    [[[self class]alloc] getbannerDate:page];
}
#pragma mark - 获取banner数据成立时，对无线轮播数据进行加载
-(void)getbannerDate:(int)page{
    //定义一个字典
    NSDictionary *dictBanner=@{@"categoryId":@(page)};
    //发送请求
    [self.manager POST:getBanner parameters:dictBanner progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //响应对象为字典（判断响应对象的键result对应的值是否是0成功则执行条件体）
        if ([responseObject[@"result"] isEqualToNumber:@0]) {
            //将请求的数据给数组
            NSArray *array=responseObject[@"data"];
            //将字典的数组转换为模型数组
            NSArray *resultNews= [BannerNews mj_objectArrayWithKeyValuesArray:array];
            //执行通知Post方法
            [[NSNotificationCenter defaultCenter]postNotificationName:GetBannerDataNotification object:resultNews];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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

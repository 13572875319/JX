//
//  GetPsas.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/23.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPsas : NSObject
@property(nonatomic, strong)NSString * title;
@property(nonatomic, strong)NSString * imageurl;
@property(nonatomic ,strong)NSNumber * commonwealId;
@property (nonatomic,strong) AFHTTPSessionManager * manager;
+(void)getPsasManager;
@end

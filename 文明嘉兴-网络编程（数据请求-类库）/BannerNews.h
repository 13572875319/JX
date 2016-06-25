//
//  BannerNews.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/12.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerNews : NSObject
@property(nonatomic ,strong)NSNumber * flashId;
@property(nonatomic, strong)NSString * imageurl;
@property(nonatomic, strong)NSString * link;
@property(nonatomic, strong)NSString * title;
@property (nonatomic,strong) AFHTTPSessionManager * manager;
+(void)receiveBannerManager:(int)page;
@end

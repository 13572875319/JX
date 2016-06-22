//
//  NewsSort.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsSort : NSObject
@property(nonatomic ,strong)NSNumber * categoryId;
@property(nonatomic, strong)NSString * categoryName;
@property(nonatomic ,strong)NSNumber * publishNum;
@property (nonatomic,strong) AFHTTPSessionManager * manager;

+(void)getNewsSort;

@end

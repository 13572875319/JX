//
//  News.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/8.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface News : NSObject
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property(nonatomic ,strong)NSNumber * newsId;
@property(nonatomic, strong)NSString * title;
@property(nonatomic, strong)NSString * summary;
@property(nonatomic, strong)NSString * source;
@property(nonatomic, strong)NSString * image;
@property(nonatomic ,strong)NSNumber * isPush;
@property(nonatomic ,strong)NSNumber * isBanner;
@property(nonatomic ,strong)NSNumber * praiseNum;
@property(nonatomic ,strong)NSNumber * browseNum;
@property(nonatomic, strong)NSString * issuestime;
+(void)receiveDataWithPageNum:(int)pageNum;





@end

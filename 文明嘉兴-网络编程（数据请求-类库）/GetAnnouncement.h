//
//  GetAnnouncement.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/23.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAnnouncement : NSObject
@property(nonatomic ,strong)NSNumber * announcementId;
@property(nonatomic, strong)NSString * title;
@property(nonatomic, strong)NSString * imageurl;
@property(nonatomic, strong)NSString * content;
@property(nonatomic, strong)NSString * createTimeStr;
@property(nonatomic,strong)AFHTTPSessionManager * manager ;
+(void)getcAnnouncementManager;
@end

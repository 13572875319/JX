//
//  NotificationTableViewCell.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC010 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "NotificationTableViewCell.h"

@implementation NotificationTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * array=[[NSBundle mainBundle]loadNibNamed:@"NotificationTableViewCell" owner:self options:nil];
        self=array[0];
    }
    return self;
}


@end

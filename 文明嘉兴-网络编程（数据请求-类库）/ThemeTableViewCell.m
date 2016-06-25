//
//  ThemeTableViewCell.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "ThemeTableViewCell.h"

@implementation ThemeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self=[[[NSBundle mainBundle]loadNibNamed:@"ThemeTableViewCell" owner:self options:nil] lastObject];
    }
    return self;
}

@end

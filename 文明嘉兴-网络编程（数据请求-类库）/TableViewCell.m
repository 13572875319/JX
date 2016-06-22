//
//  TableViewCell.m
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/4.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //载入xib
        self=[[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
        //将图片设置成圆角
        self.image.layer.cornerRadius=10;
        self.image.layer.masksToBounds=YES;
    }
    return self;
}
@end

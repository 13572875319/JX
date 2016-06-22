//
//  TableViewCell.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/4.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *issuestime;
@property (weak, nonatomic) IBOutlet UILabel *praiseNum;
@property (weak, nonatomic) IBOutlet UILabel *browseNum;

@end

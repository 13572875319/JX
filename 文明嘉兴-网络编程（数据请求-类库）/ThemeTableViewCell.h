//
//  ThemeTableViewCell.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC004 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end

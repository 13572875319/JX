//
//  NotificationTableViewCell.h
//  文明嘉兴-网络编程（数据请求-类库）
//
//  Created by DC010 on 16/6/22.
//  Copyright © 2016年 段东刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

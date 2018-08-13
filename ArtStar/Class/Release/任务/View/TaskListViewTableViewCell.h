//
//  TaskListViewTableViewCell.h
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *statusBtu;

@end

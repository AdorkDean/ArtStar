//
//  MineChooseMyHomeVC.h
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "BaseVC.h"

@interface MineChooseMyHomeVC : BaseVC

@property (nonatomic,copy) void(^chooseHomeTwon)(NSString *country,NSString *provices,NSString *city);

@end

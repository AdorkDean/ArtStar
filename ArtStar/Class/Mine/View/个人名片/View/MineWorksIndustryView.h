//
//  MineWorksIndustryView.h
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineWorksIndustryView : UIView

@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *cancelStr;
@property (nonatomic,copy) void (^sendChooseworks)(NSString *name,NSString *ID);

@end

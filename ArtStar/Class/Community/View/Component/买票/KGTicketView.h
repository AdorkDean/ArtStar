//
//  KGTicketView.h
//  ArtStar
//
//  Created by abc on 2018/6/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGTicketView : UIView

@property (nonatomic,copy) void(^theTicketAction)(void);

@end

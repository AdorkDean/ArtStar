//
//  CommunityHeaderScrollView.h
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityHeaderScrollView : UIView

@property (nonatomic,copy) NSArray *itemArr;
@property (nonatomic,copy) void (^rightAction)(NSString *title);
@property (nonatomic,copy) void (^titleAction)(NSString *title);

@end

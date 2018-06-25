//
//  CustomBtu.h
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonAction)(NSString *str);

@interface CustomBtu : UIView

@property (nonatomic,copy) ButtonAction action;
@property (nonatomic,assign) CGFloat font;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image;

@end

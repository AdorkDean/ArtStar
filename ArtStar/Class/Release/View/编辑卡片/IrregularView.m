//
//  IrregularView.m
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "IrregularView.h"

@interface IrregularView ()
/**
 遮罩
 */
@property (nonatomic,strong) CAShapeLayer *maskLayer;
/**
 路径
 */
@property (nonatomic,strong) UIBezierPath *borderPath;


@end

@implementation IrregularView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createLayer];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    NSArray *arr = @[@"公开",@"仅自己可见",@"朋友圈可见"];
    for (int i = 0; i < arr.count; i++) {
        UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
        btu.frame = CGRectMake(0, 10 + 30*i,self.bounds.size.width, 30);
        [btu setTitle:arr[i] forState:UIControlStateNormal];
        [btu setTitleColor:Color_999999 forState:UIControlStateNormal];
        btu.titleLabel.font = FZFont(12);
        [btu addTarget:self action:@selector(sendTitle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btu];
        if (i >= 1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 10 + 30*i, self.bounds.size.width - 20, 1)];
            line.backgroundColor = Color_cccccc;
            [self addSubview:line];
        }
    }
}
- (void)sendTitle:(UIButton *)sender{
    if (_sendStr) {
        self.sendStr(sender.currentTitle);
    }
    self.hidden = YES;
}

- (void)createLayer{

    self.maskLayer = [CAShapeLayer layer];
    self.borderPath = [UIBezierPath bezierPath];
    //:--设置遮罩的frame--
    self.maskLayer.frame = CGRectMake(0, 0, ViewWidth(self), ViewHeight(self));
    self.maskLayer.lineWidth = 1;
    CGRect frame = self.frame;
    //:--设置起点--
    [self.borderPath moveToPoint:CGPointMake(0, 15)];
    //:--设置左上角圆角--
    [self.borderPath addQuadCurveToPoint:CGPointMake(5, 10) controlPoint:CGPointMake(0, 10)];
    //:--直线--
    [self.borderPath addLineToPoint:CGPointMake(frame.size.width/5*3, 10)];
    //:--设置小三角左侧--
    [self.borderPath addLineToPoint:CGPointMake(frame.size.width/5*3 + 10, 0)];
    //:--设置小三角右侧--
    [self.borderPath addLineToPoint:CGPointMake(frame.size.width/5*3 + 20, 10)];
    //:--设置直线--
    [self.borderPath addLineToPoint:CGPointMake(frame.size.width - 5, 10)];
    //:--设置右上角圆角--
    [self.borderPath addQuadCurveToPoint:CGPointMake(frame.size.width, 15) controlPoint:CGPointMake(frame.size.width, 10)];
    //:--直线--
    [self.borderPath addLineToPoint:CGPointMake(frame.size.width, frame.size.height - 5)];
    //:--设置右下角圆角--
    [self.borderPath addQuadCurveToPoint:CGPointMake(frame.size.width - 5, frame.size.height) controlPoint:CGPointMake(frame.size.width, frame.size.height)];
    //:--直线--
    [self.borderPath addLineToPoint:CGPointMake(5, frame.size.height)];
    //:--这是左下角圆角--
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, frame.size.height - 5) controlPoint:CGPointMake(0, frame.size.height)];
    //:--直线--
    [self.borderPath addLineToPoint:CGPointMake(0, 15)];

    self.maskLayer.fillColor = Color_f2f2f2.CGColor;
    self.maskLayer.strokeColor = Color_cccccc.CGColor;
    self.maskLayer.masksToBounds = YES;
    //:--将path赋值给layer--
    self.maskLayer.path = self.borderPath.CGPath;
    [self.layer addSublayer:self.maskLayer];
}
//- (void)drawRect:(CGRect)rect{
//
//}

@end

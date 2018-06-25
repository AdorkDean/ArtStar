//
//  MySelfWordPerformanView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MySelfWordPerformanView.h"
#import "TheEndCell.h"
#import "MyselfPerformanViewCell.h"

@interface MySelfWordPerformanView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIView *line;


@end

@implementation MySelfWordPerformanView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTableViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"TheEndCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TheEndCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MyselfPerformanViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfPerformanViewCell"];
}

- (UIView *)setTableViewHeaderView{
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 40)];
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(0, 0, ViewWidth(_headerView)/2, 40);
    [_leftBtu setTitle:@"即将演出" forState:UIControlStateNormal];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(14);
    [_leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(ViewWidth(_headerView)/2, 0, ViewWidth(_headerView)/2, 40);
    [_rightBtu setTitle:@"历史演出" forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(14);
    [_rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_rightBtu];
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(_headerView)/2, 7.5, 1, 25)];
    hLine.backgroundColor = Color_ededed;
    [_headerView addSubview:hLine];
    
    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(0, 39, ViewWidth(_headerView), 1)];
    vLine.backgroundColor = Color_ededed;
    [_headerView addSubview:vLine];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 38, 70, 2)];
    _line.centerX = _leftBtu.centerX;
    _line.backgroundColor = Color_333333;
    [_headerView addSubview:_line];
    
    return _headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 10) {
        return 95;
    }else{
        return 140;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 10) {
        TheEndCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheEndCell"];
        return cell;
    }else{
        MyselfPerformanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfPerformanViewCell"];
        return cell;
    }
    
}

- (void)leftAction:(UIButton *)sender{
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = self.leftBtu.centerX;
    }];
}
- (void)rightAction:(UIButton *)sender{
    [_leftBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = self.rightBtu.centerX;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

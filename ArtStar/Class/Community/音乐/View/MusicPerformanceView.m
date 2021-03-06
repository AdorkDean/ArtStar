//
//  MusicPerformanceView.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicPerformanceView.h"
#import "MusicPerformanceCell.h"

@interface MusicPerformanceView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic,strong) HeaderScrollAndPageView *pageView;
@property (nonatomic,strong) UITableView *lietView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,assign) NSInteger page;//:--加载页--

@end


@implementation MusicPerformanceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        _page = 1;
    }
    return self;
}

- (void)setUI{
    _lietView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _lietView.delegate = self;
    _lietView.dataSource = self;
    _lietView.emptyDataSetDelegate = self;
    _lietView.emptyDataSetSource = self;
    _lietView.tableHeaderView = [self setTableView];
    _lietView.tableFooterView = TabLeViewFootView;
    _lietView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakSelf = self;
    // TODO: --下拉刷新数据，设置数据请求页为第一页--
    _lietView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        if (weakSelf.refreshHeader) {
            weakSelf.refreshHeader();
        }
        // TODO: --开始转圈刷新--
        [weakSelf.lietView.mj_header beginRefreshing];
    }];
    // TODO: --上拉加载更多，设置数据请求页递增--
    _lietView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        if (weakSelf.reloadFoot) {
            weakSelf.reloadFoot(weakSelf.page);
        }
        // TODO: --开始转圈加载--
        [weakSelf.lietView.mj_footer beginRefreshing];
    }];
    [self addSubview:_lietView];
    
    [_lietView registerClass:[MusicPerformanceCell class] forCellReuseIdentifier:@"MusicPerformanceCell"];
    
}

- (UIView *)setTableView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewWidth(self)/750*500 + 40 + 60)];
    
    _pageView = [[HeaderScrollAndPageView alloc]initWithFrame:_headerView.bounds style:HeaderStyleOther];
    __weak typeof(self) weakSelf = self;
    // TODO: --接受点击近期热门，即将开始，即将结束事件--
    _pageView.classTypeAction = ^(NSString *type) {
        if (weakSelf.classTypeAction) {
            weakSelf.classTypeAction(type);
        }
    };
    [_headerView addSubview:_pageView];
    
    return _headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    if (dic[@"showprice"] != nil) {
        return (ViewWidth(self) - 30)/690*400 + 105;// TODO: --有门票--
    }else{
        return (ViewWidth(self) - 30)/690*400 + 65;// TODO: --没有门票--
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicPerformanceCell"];
    NSDictionary *dic = _dataArr[indexPath.row];
    NSDictionary *imageDic = [dic[@"imgList"] firstObject];
    [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"locationimg"]]];
    cell.titleLab.text = dic[@"showname"];
    cell.locationLab.text = dic[@"showaddress"];
    if (![dic[@"startday"] isKindOfClass:[NSNull class]]) {
        cell.timeLab.text = [NSString stringWithFormat:@"还有%@天开始",dic[@"startday"]];
        if ([dic[@"showprice"] isKindOfClass:[NSNull class]]) {
            [cell normalStatus];
        }else{
            [cell willStarStatus];
        }
    }else if (![dic[@"endday"] isKindOfClass:[NSNull class]]){
        cell.timeLab.text = [NSString stringWithFormat:@"还有%@天结束",dic[@"endday"]];
        if ([dic[@"showprice"] isKindOfClass:[NSNull class]]) {
            [cell normalStatus];
        }else{
            [cell willEndStatus];
        }
    }else if (![dic[@"daingday"] isKindOfClass:[NSNull class]]){
        cell.timeLab.text = [NSString stringWithFormat:@"已经开始%@天",dic[@"daingday"]];
        if ([dic[@"showprice"] isKindOfClass:[NSNull class]]) {
            [cell normalStatus];
        }else{
            [cell willEndStatus];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    if (self.pushToDetaialVC) {
        self.pushToDetaialVC([NSString stringWithFormat:@"%@",dic[@"id"]]);
    }
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    if (_dataArr.count == 0) {
        _lietView.mj_footer.hidden = YES;
    }else{
        _lietView.mj_footer.hidden = NO;
    }
    [_lietView.mj_header endRefreshing];
    [_lietView.mj_footer endRefreshing];
    [_lietView reloadData];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"木有内容哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

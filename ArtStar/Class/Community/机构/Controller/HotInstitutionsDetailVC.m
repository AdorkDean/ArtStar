//
//  HotInstitutionsDetailVC.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotInstitutionsDetailVC.h"
#import "HotMoviesDetailCommentCell.h"

@interface HotInstitutionsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation HotInstitutionsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 250, 30) title:@"全部评论（300）" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [NSMutableArray array];
    [self createData];
    [self setTbaleView];
    [self setBottomCommentView];
}

- (void)setBottomCommentView{
    KGLowCommentView *commentView = [[KGLowCommentView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    commentView.actionWithTitle = ^(NSString *title, NSString *text) {
        if ([title isEqualToString:@"评论"]) {
            
        }
    };
    [self.view addSubview:commentView];
}

- (void)setTbaleView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.rowHeight = 140;
    [self.view addSubview:_listView];
    
    [_listView registerClass:[HotMoviesDetailCommentCell class] forCellReuseIdentifier:@"HotMoviesDetailCommentCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotMoviesDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotMoviesDetailCommentCell"];
    if (_dataArr.count > 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nameLab.text = dic[@"username"];
        cell.commentLab.text = dic[@"pingjia"];
        cell.timeLab.text = dic[@"pltime"];
        if (![dic[@"pingfen"] isKindOfClass:[NSNull class]]) {
            cell.pingfen = [dic[@"pingfen"] integerValue];
        }
    }
    return cell;
}
// MARK: --请求所有评论--
- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:selectShowPlistjById parameters:@{@"id":_userId,@"query":@{@"rows":@"15",@"page":@"1"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf setLeftBtuWithFrame:CGRectMake(0, 0, 250, 30) title:[NSString stringWithFormat:@"全部评论（%li）",weakSelf.dataArr.count] image:Image(@"back")];
        [weakSelf.listView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

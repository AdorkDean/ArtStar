//
//  FriendsMessageVC.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsMessageVC.h"
#import "FriednsMessageCell.h"
#import "FriendsDeleteAllMessageView.h"

@interface FriendsMessageVC ()<UITableViewDelegate,UITableViewDataSource,FriendsDeleteAllMessageViewDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) FriendsDeleteAllMessageView *deleteView;

@end

@implementation FriendsMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"消息" image:Image(@"back")];
    [self setRightBtuWithTitle:nil image:Image(@"empty")];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    [self setUpTableView];
}
- (void)rightNavBtuAction:(UIButton *)sender{
    self.deleteView.hidden = NO;
}

- (void)setUpTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 75;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"FriednsMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriednsMessageCell"];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"屏蔽" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    editAction.backgroundColor = Color_cccccc;
    return @[deleteAction,editAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriednsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriednsMessageCell"];
    if (indexPath.row %2 == 0) {
        [cell showZansImage];
    }
    return cell;
}

- (FriendsDeleteAllMessageView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[FriendsDeleteAllMessageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _deleteView.delegate = self;
        [self.navigationController.view addSubview:_deleteView];
    }
    return _deleteView;
}
//MARK:--FriendsDeleteAllMessageViewDelegate--
- (void)deleteAllMessage{
    
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

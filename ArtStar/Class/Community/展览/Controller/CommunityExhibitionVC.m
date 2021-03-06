//
//  CommunityExhibitionVC.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionVC.h"
#import "HeadLinesDetailVC.h"
#import "MusicPerformanceView.h"
#import "PerformanceDetailVC.h"
#import "CommunityExhibitionDetailVC.h"

@interface CommunityExhibitionVC ()

@property (nonatomic,strong) MusicPerformanceView *performanceView;//:--演出--
@property (nonatomic,copy) NSString *currtitleStr;//:--当前顶部标题--
@property (nonatomic,copy) NSString *currClassStr;//:--当前中间分类--
@property (nonatomic,strong) NSMutableArray *dataArr;//:--保存数据--
@property (nonatomic,assign) NSInteger page;//:--页数--
@property (nonatomic,strong) KGSearchBarAndSearchView *searchView;
@property (nonatomic,copy) NSArray *historyArr;
@property (nonatomic,copy) NSArray *hotArr;

@end

@implementation CommunityExhibitionVC

- (void)setSearchBar{
    UIButton *searchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtu.frame = CGRectMake(0, 0, kScreenWidth - 75, 30);
    searchBtu.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    [searchBtu setImage:Image(@"search") forState:UIControlStateNormal];
    [searchBtu setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtu.titleLabel.font = SYFont(12);
    [searchBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [searchBtu addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self setNavTitleView:searchBtu];
}

- (void)rightNavBtuAction:(UIButton *)sender{
    [self pushNoTabBarViewController:[[MIneMessageVC alloc]init] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more popup message")];
    self.view.backgroundColor = [UIColor whiteColor];
    // TODO: --在这里初始化以及给定默认值--
    _currtitleStr = @"美术";
    _currClassStr = @"近期热门";
    _page = 1;
    _dataArr = [NSMutableArray array];
    // TODO: --先请求数据，然后加载页面，但是因为网速问题，可能页面加载出来，但是数据还没有显示，所以记得刷新--
    [self searchHistory];
    [self createHeadLineData];
    [self setSearchBar];
    [self setTopView];
}
- (void)setTopView{
    __weak typeof(self) mySelf = self;
    //MARK:---------------------------顶部滚动条--------------------
    CommunityHeaderScrollView *scrollerView = [[CommunityHeaderScrollView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 40)];
    scrollerView.itemArr = @[@"美术",@"摄影",@"设计"];
    //MARK:---------------------------------滚动条按钮点击事件-----------------------
    scrollerView.titleAction = ^(NSString *title) {
        mySelf.currtitleStr = title;
        mySelf.dataArr = [NSMutableArray array];
        [mySelf createHeadLineData];
    };
    [self.view addSubview:scrollerView];
    [self.view insertSubview:self.performanceView atIndex:99];
}
//MARK:-------------------------------------展览-------------------------------
- (MusicPerformanceView *)performanceView{
    __weak typeof(self) mySelf = self;
    if (!_performanceView) {
        _performanceView = [[MusicPerformanceView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 40, kScreenWidth, kScreenHeight - NavTopHeight - 40)];
        // TODO: --点击cell进行页面跳转--
        _performanceView.pushToDetaialVC = ^(NSString *ID) {
            CommunityExhibitionDetailVC *vc = [[CommunityExhibitionDetailVC alloc]init];
            vc.ID = ID;
            [mySelf pushNoTabBarViewController:vc animated:YES];
        };
        // TODO: --点击近期热门，即将开始，即将结束的数据请求--
        _performanceView.classTypeAction = ^(NSString *classStr) {
            mySelf.currClassStr = classStr;
            mySelf.dataArr = [NSMutableArray array];
            [mySelf createHeadLineData];
        };
        // TODO: --下拉刷新列表--
        _performanceView.refreshHeader = ^{
            mySelf.page = 1;
            mySelf.dataArr = [NSMutableArray array];
            [mySelf createHeadLineData];
        };
        // TODO: --上拉加载更多--
        _performanceView.reloadFoot = ^(NSInteger page) {
            mySelf.page = page;
            [mySelf createHeadLineData];
        };
        [self.view addSubview:_performanceView];
    }
    return _performanceView;
}
/**
 监听导航栏的输入框，替换事件
 */
- (void)searchAction{
    self.searchView.hidden = NO;
    self.searchView.historyArr = _historyArr;
    self.searchView.hotArr = _hotArr;
    self.searchView.searchUrl = deleteSearchShow;
}
/**
 数据请求
 */
- (void)createHeadLineData{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在努力加载中..."];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:selectSlistByTypename parameters:@{@"typename":_currtitleStr,@"navigation":_currClassStr,@"page":@(_page),@"rows":@"15"} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmpArr = result[@"data"];
            // TODO: --在这里不是直接copy而是遍历add的原因是，可能点击上拉加载更多的话数据一直是15条，而且开始的数据就会消失--
            for (int i = 0; i < tmpArr.count; i++) {
                [weakSelf.dataArr addObject:tmpArr[i]];
            }
            weakSelf.performanceView.dataArr = weakSelf.dataArr.copy;
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --搜索页面--
- (KGSearchBarAndSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[KGSearchBarAndSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        // !!!: --搜索新闻--
        _searchView.searchResult = ^(NSString *result) {
            [mySelf searchExhibition:result];
            mySelf.searchView.hidden = YES;
        };
        // !!!: --点击搜索历史，直接快速搜索--
        _searchView.clickSearchTitle = ^(NSString *title) {
            [mySelf searchExhibition:title];
            mySelf.searchView.hidden = YES;
        };
        [self.navigationController.view addSubview:_searchView];
    }
    return _searchView;
}
// MARK: --搜索展览--
- (void)searchExhibition:(NSString *)title{
    _dataArr = [NSMutableArray array];
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在努力加载中..."];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:showSearch parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"typename":_currClassStr,@"page":@(_page),@"rows":@"15"} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmpArr = result[@"data"];
            // TODO: --在这里不是直接copy而是遍历add的原因是，可能点击上拉加载更多的话数据一直是15条，而且开始的数据就会消失--
            for (int i = 0; i < tmpArr.count; i++) {
                [weakSelf.dataArr addObject:tmpArr[i]];
            }
            weakSelf.performanceView.dataArr = weakSelf.dataArr.copy;
        }else{
            weakSelf.performanceView.dataArr = weakSelf.dataArr.copy;
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --展览搜索历史--
- (void)searchHistory{
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:oldSearchShow parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"query":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.historyArr = result[@"data"];
        }
    } fail:^(NSError *error) {
        
    }];
    
    [KGRequestNetWorking postWothUrl:hotSearchShow parameters:@{} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.hotArr = result[@"data"];
        }
    } fail:^(NSError *error) {
        
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

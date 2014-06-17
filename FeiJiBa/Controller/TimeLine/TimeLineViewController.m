//
//  TimeLineViewController.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TimeLineCell.h"
#import "DSTimeLineCell.h"
#import "TimeLineModel.h"
#import "TimeLineHeaderView.h"
#import "MJRefresh.h"
#import "DetailViewController.h"

@interface TimeLineViewController ()

/**
 *  显示动态信息的 tableview
 */
@property (weak, nonatomic) IBOutlet UITableView *timeLineTableView;

/**
 *  YES表示当前为砖家解答，NO表示为屌丝解答
 */
@property (assign, nonatomic) BOOL isPro;

/**
 *  动态的数据数组 (当选择是砖家时则把砖家的数据赋给这个数组，当选择是屌丝的时候则把屌丝的数据赋给这个数组)
 */
@property (strong, nonatomic) NSArray *timeLineArray;

/**
 *  砖家数据数组  (考虑到要下拉刷新之类的操作，所以定为mutable)
 */
@property (strong, nonatomic) NSMutableArray *zhuanJiaArray;

/**
 *  屌丝的数据数组
 */
@property (strong, nonatomic) NSMutableArray *diaosiArray;

/**
 *  记录当前的页数 (砖家)
 */
@property (assign, nonatomic) int proPageNumber;

/**
 *  记录当前的页数 (屌丝)
 */
@property (assign, nonatomic) int dsPageNumber;

@end

@implementation TimeLineViewController

#pragma mark - ios lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.proPageNumber = 0;
    self.dsPageNumber = 0;
    self.isPro = YES;
    self.zhuanJiaArray = @[].mutableCopy;
    self.diaosiArray = @[].mutableCopy;
    [self setupRefresh];
    [self getProArray];
    
    /**
     *  设置 表的头部视图
     */
    self.timeLineTableView.tableHeaderView = [TimeLineHeaderView getTimeLineHeaderView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - set方法中刷新表数据

- (void)setTimeLineArray:(NSArray *)timeLineArray
{
    if (timeLineArray) {
        _timeLineArray = timeLineArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.timeLineTableView reloadData];
            if (self.isPro) {
                if (self.proPageNumber==0) {
                    [self.timeLineTableView headerEndRefreshing];

                }else
                {
                    [self.timeLineTableView footerEndRefreshing];

                }
            }else
            {
                if (self.dsPageNumber==0) {
                    [self.timeLineTableView headerEndRefreshing];
                    
                }else
                {
                    [self.timeLineTableView footerEndRefreshing];
                    
                }
            }
            
        });
        
    }
}

#pragma mark - 获取 砖家和屌丝数据

- (void)getProArray
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *proArr = [TimeLineModel getProDataByPage:_proPageNumber];
        if (proArr.count==0&&self.proPageNumber!=0) {
            NSLog(@"已经是最后一页了");
        }
        if (self.proPageNumber==0) {
            [self.zhuanJiaArray removeAllObjects];
            [self.zhuanJiaArray addObjectsFromArray:proArr];
        }else
        {
            [proArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                TimeLineModel *model = (TimeLineModel *)obj;
                __block BOOL isSame = NO;
                [self.zhuanJiaArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    TimeLineModel *modelZ = (TimeLineModel *)obj;
                    if ([model.objectID isEqualToString:modelZ.objectID]) {
                        isSame = YES;
                        *stop = YES;
                    }
                }];
                if (!isSame) {
                    [self.zhuanJiaArray addObject:model];
                }
            }];
        }
        self.timeLineArray = self.zhuanJiaArray.copy;
    });
    
}

- (void)getDSArray
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *dsArr = [TimeLineModel getDSDataByPage:_dsPageNumber];
        if (dsArr.count==0&&self.dsPageNumber!=0) {
            NSLog(@"已经是最后一页了");
        }
        if (self.dsPageNumber==0) {
            [self.diaosiArray removeAllObjects];
            [self.diaosiArray addObjectsFromArray:dsArr];
        }else
        {
            [dsArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                TimeLineModel *model = (TimeLineModel *)obj;
                __block BOOL isSame = NO;
                [self.diaosiArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    TimeLineModel *modelZ = (TimeLineModel *)obj;
                    if ([model.objectID isEqualToString:modelZ.objectID]) {
                        isSame = YES;
                        *stop = YES;
                    }
                }];
                if (!isSame) {
                    [self.diaosiArray addObject:model];
                }
            }];
        }
        self.timeLineArray = self.diaosiArray.copy;
    });
}

#pragma mark - 集成刷新控件

- (void)setupRefresh
{
    [self.timeLineTableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    [self.timeLineTableView headerBeginRefreshing];
    
    [self.timeLineTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    if (self.isPro) {
        self.proPageNumber = 0;
        [self getProArray];

    }else
    {
        self.dsPageNumber = 0;
        [self getDSArray];

    }
    
    
}

- (void)footerRereshing
{
    if (self.isPro) {
        self.proPageNumber++;
        [self getProArray];

    }else
    {
        self.dsPageNumber++;
        [self getDSArray];

    }
    
}


#pragma mark - 切换 砖家列表 或 屌丝列表

- (IBAction)ZhuanJiaOrDiaoSi:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    if (segment.selectedSegmentIndex==0) {  //砖家
        NSLog(@"zhuan jia");
        self.isPro = YES;
        [self getProArray];
        if (self.proPageNumber==0) {
            [self.timeLineTableView setContentOffset:CGPointMake(0, -60) animated:YES];
        }
    }else    //屌丝
    {
        NSLog(@"diao si");
        self.isPro = NO;
        [self getDSArray];
        if (self.dsPageNumber==0) {
            [self.timeLineTableView setContentOffset:CGPointMake(0, -60) animated:YES];
        }
    }
    
}


#pragma mark - UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeLineArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id tableCell = nil;
    if (_isPro) {
        NSString *identifier = @"TimeLineCell";

        TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [TimeLineCell getTimeLineCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setDataSource:self.timeLineArray[indexPath.row]];
        tableCell = cell;
    }else
    {
        NSString *identifier = @"DSTimeLineCell";

        DSTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [DSTimeLineCell getDSTimeLineCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setDataSource:self.timeLineArray[indexPath.row]];
        tableCell = cell;
    }
    
    return tableCell;
}


#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailViewController *detail = [story instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detail.isPro = self.isPro;
    detail.dataModel = self.timeLineArray[indexPath.row];
    [self presentViewController:detail animated:YES completion:nil];

    
}



@end

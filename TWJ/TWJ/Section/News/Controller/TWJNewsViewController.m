//
//  TWJNewsViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/8.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJNewsViewController.h"
#import "TWJNewsTableViewCell.h"
#import "TWJNewsModel.h"
#import "TWJNewsDetailViewController.h"

@interface TWJNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *newsBabyTableview;
@property (nonatomic,strong)NSMutableArray *newsArray;

@end

@implementation TWJNewsViewController
#pragma mark get
- (UITableView *)newsBabyTableview {
    if (!_newsBabyTableview) {
        _newsBabyTableview = [[UITableView alloc] init];
        _newsBabyTableview.delegate = self;
        _newsBabyTableview.dataSource = self;
        _newsBabyTableview.tableFooterView = [UIView new];
    }
    return _newsBabyTableview;
}

- (NSMutableArray *)newsArray {
    if (!_newsArray) {
        _newsArray = [[NSMutableArray alloc] init];
    }
    return _newsArray;
}

#pragma mark life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"育儿知识";
    
    [self.view addSubview:self.newsBabyTableview];
    
    [self.newsBabyTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.view.mas_top);
    }];
    
    [self getNewsData];
    
}

#pragma mark network
- (void)getNewsData {
    
    [[TWJhttpClient sharedClient] requestNews:@"" success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) {
            NSArray *array =[NSArray yy_modelArrayWithClass:[TWJNewsModel class] json:responseObject[@"data"][@"dy"]];
            [self.newsArray addObjectsFromArray:array];
        }
        [self.newsBabyTableview reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJNewsTableViewCell";
    TWJNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    TWJNewsModel *model = [self.newsArray objectAtIndex:indexPath.row];
    if (model.picInfo.count > 0) {
        NSDictionary *dic = model.picInfo[0];
        NSString *imageLink = [dic objectForKey:@"url"];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageLink] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.digest;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TWJNewsModel *model = [self.newsArray objectAtIndex:indexPath.row];
    TWJNewsDetailViewController *ctrl = [TWJNewsDetailViewController new];
    ctrl.link = model.link;
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end

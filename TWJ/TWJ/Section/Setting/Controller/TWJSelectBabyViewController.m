//
//  TWJSelectBabyViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJSelectBabyViewController.h"
#import "TWJSelectBabyTableViewCell.h"
#import "TWJAddBabyViewController.h"
#import "TWJTemperatureRecordViewController.h"

@interface TWJSelectBabyViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,TWJAddBabyViewControllerDelegate>

@property (nonatomic,strong)UITableView *selectBabyTableview;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)NSMutableArray *babyListArray;
@property (nonatomic,strong)NSIndexPath *selectPath;

@end

@implementation TWJSelectBabyViewController
#pragma mark get
- (UITableView *)selectBabyTableview {
    if (!_selectBabyTableview) {
        _selectBabyTableview = [[UITableView alloc] init];
        _selectBabyTableview.delegate = self;
        _selectBabyTableview.dataSource = self;
        _selectBabyTableview.tableFooterView = [UIView new];
    }
    return _selectBabyTableview;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setTitle:@"添加宝贝" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.backgroundColor = APP_HEXCOLOR(@"#00c9af");
        [_addButton addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchDown];
        _addButton.layer.cornerRadius = 22;
    }
    return _addButton;
}

- (NSMutableArray *)babyListArray {
    if (!_babyListArray) {
        _babyListArray = [[NSMutableArray alloc] init];
    }
    return _babyListArray;
}

#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择宝贝";
    
    NSArray *array = [[TWJDataBaseManager sharedInstance] getAllBabyinfo];
    [self.babyListArray addObjectsFromArray:array];
    
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.selectBabyTableview];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(44));
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
    }];
    
    [self.selectBabyTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.addButton.mas_top).offset(-16);
        make.top.equalTo(self.view.mas_top);
    }];
}

#pragma mark click
- (void)clickAdd {
    TWJAddBabyViewController *ctrl = [TWJAddBabyViewController new];
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
}


#pragma mark TWJAddBabyViewControllerDelegate
- (void)addBabySuccess {
    [self.babyListArray removeAllObjects];
    NSArray *array = [[TWJDataBaseManager sharedInstance] getAllBabyinfo];
    [self.babyListArray addObjectsFromArray:array];
    [self.selectBabyTableview reloadData];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.babyListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJSelectBabyTableViewCell";
    TWJSelectBabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJSelectBabyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (self.selectPath) {
        if (self.selectPath.row == indexPath.row) {
            cell.selectbutton.selected = YES;
        }else {
            cell.selectbutton.selected = NO;
        }
    }else {
        cell.selectbutton.selected = NO;
    }
    
    TWJBabyInfoModel *model = [self.babyListArray objectAtIndex:indexPath.row];
    if (model.icon && model.icon.length > 0) {
        NSString *path_document = NSHomeDirectory();
        NSString *namePath = [NSString stringWithFormat:@"/Documents/%@.png",model.icon];
        NSString *imagePath = [path_document stringByAppendingString:namePath];
        cell.headerImageView.image = [UIImage imageWithContentsOfFile:imagePath] ;
    }else {
        if ([model.sex integerValue] == 1) {
            cell.headerImageView.image = [UIImage imageNamed:@"defualt_man"];
        }else {
            cell.headerImageView.image = [UIImage imageNamed:@"defualt_woman"];
        }
    }
    
    cell.nameLabel.text = model.name;
    cell.agelabel.text = [NSString stringWithFormat:@"|  %@",model.age];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectPath = indexPath;
    
    [tableView reloadData];
    
    TWJBabyInfoModel *model = [self.babyListArray objectAtIndex:indexPath.row];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"选择宝宝“%@ | %@？”",model.name,model.age] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertview.tag = 11000;
    [alertview show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        alertView.tag = indexPath.row;
        [alertView show];
    }
}

#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 11000) {
        if (buttonIndex == 1) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectBabyInfo:)]) {
                TWJBabyInfoModel *model = [self.babyListArray objectAtIndex:self.selectPath.row];
                [self.delegate selectBabyInfo:model];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        if (buttonIndex == 1) {
            if (self.babyListArray.count == 1) {
                [SVProgressHUD showInfoWithStatus:@"测量宝贝不能为空，请先添加新的测量宝贝再删除"];
                return;
            }
            TWJBabyInfoModel *model = [self.babyListArray objectAtIndex:alertView.tag];
            
            [[TWJDataBaseManager sharedInstance] deleteBabyWithModel:model];
            [self.babyListArray removeObject:model];
            
            [self.selectBabyTableview reloadData];
        }
    }
}

@end

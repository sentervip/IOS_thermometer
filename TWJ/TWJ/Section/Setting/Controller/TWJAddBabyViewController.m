//
//  TWJAddBabyViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/16.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJAddBabyViewController.h"
#import "TWJAddbabyTableViewCell.h"
#import "TWJAddHeaderView.h"
#import "TWJBabyInfoModel.h"
#import "TWJTimePickerView.h"
#import "TWJMainViewController.h"

@interface TWJAddBabyViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,TWJTimePickerViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *addTableview;
@property (nonatomic,strong) UIButton *saveButton;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong)TWJAddHeaderView *addHeaderView;
@property (nonatomic,strong)TWJAddFooterView *addFooterView;

@property (nonatomic,strong)TWJBabyInfoModel *babyInfoModel;

@end


@implementation TWJAddBabyViewController

#pragma mark get
- (TWJBabyInfoModel *)babyInfoModel {
    if (!_babyInfoModel) {
        _babyInfoModel = [TWJBabyInfoModel new];
    }
    return _babyInfoModel;
}

- (TWJAddHeaderView *)addHeaderView {
    if (!_addHeaderView) {
        _addHeaderView = [[TWJAddHeaderView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 80)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeader)];
        tap.numberOfTapsRequired = 1;
        _addHeaderView.userInteractionEnabled = YES;
        [_addHeaderView addGestureRecognizer:tap];
    }
    return _addHeaderView;
}

- (TWJAddFooterView *)addFooterView {
    if (!_addFooterView) {
        _addFooterView = [[TWJAddFooterView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 50)];
    }
    return _addFooterView;
}

- (UITableView *)addTableview {
    if (!_addTableview) {
        _addTableview = [[UITableView alloc] init];
        _addTableview.delegate = self;
        _addTableview.dataSource = self;
        _addTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _addTableview;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveButton.backgroundColor = APP_HEXCOLOR(@"#00c9af");
        [_saveButton addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchDown];
        _saveButton.layer.cornerRadius = 22;
    }
    return _saveButton;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.font = TWJFont(12);
        _tipsLabel.textColor = APP_HEXCOLOR(@"#999999");
        _tipsLabel.text = @"为了更好的检测每个宝宝的体温，请您准确录入宝宝信息";
    }
    return _tipsLabel;
}


#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加宝贝";
    
    [self configSubviews];
    
    self.addTableview.tableHeaderView = self.addHeaderView;
    self.addTableview.tableFooterView = self.addFooterView;
}

- (void)configSubviews {
    [super configSubviews];
    
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.addTableview];
    [self.view addSubview:self.tipsLabel];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(44));
        make.bottom.equalTo(self.view.mas_bottom).offset(-25);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.saveButton.mas_top).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.addTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.saveButton.mas_top).offset(-16);
        make.top.equalTo(self.view.mas_top);
    }];
}

#pragma mark click
- (void)clickSave {
    if (!self.babyInfoModel.name || self.babyInfoModel.name.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写名称"];
        return;
    }
    
    if (!self.babyInfoModel.sex || self.babyInfoModel.sex.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择性别"];
        return;
    }
    
    if (!self.babyInfoModel.age || self.babyInfoModel.age.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请选择年龄"];
        return;
    }
    
    if (self.addFooterView.footSwitch.on) {
        self.babyInfoModel.isCe = @"1";
    }else {
        self.babyInfoModel.isCe = @"0";
    }
    
    if (self.babyInfoModel.icon && self.babyInfoModel.icon.length > 0) {
        
    }else {
        self.babyInfoModel.icon = @"";
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *addTime = [df stringFromDate:[NSDate date]];
    self.babyInfoModel.addTime = addTime;
    
    [[TWJDataBaseManager sharedInstance] insertBabyinfoWithModel:self.babyInfoModel];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addBabySuccess)]) {
        [self.delegate addBabySuccess];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isFromRoot) {
            TWJMainViewController *ctrl = [TWJMainViewController new];
            [UIApplication sharedApplication].delegate.window.rootViewController = ctrl;
            [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    });
}

-(void)clickHeader {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil];
    action.tag = 1100;
    [action showInView:self.view];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJAddbabyTableViewCell";
    TWJAddbabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJAddbabyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentTextField.userInteractionEnabled = NO;
    cell.arrowImageview.hidden = NO;
    if (indexPath.row == 0) {
        cell.titlelabel.text = @"昵称";
        cell.contentTextField.placeholder = @"宝宝叫什么";
        cell.contentTextField.userInteractionEnabled = YES;
        cell.arrowImageview.hidden = YES;
        if (self.babyInfoModel.name && self.babyInfoModel.name.length > 0) {
            cell.contentTextField.text = self.babyInfoModel.name;
        }
        cell.contentTextField.delegate = self;
    }else if (indexPath.row == 1) {
        cell.titlelabel.text = @"性别";

        if (self.babyInfoModel.sex && self.babyInfoModel.sex.length > 0) {
            if ([self.babyInfoModel.sex integerValue] == 1) {
                cell.contentTextField.text = @"男";
            }else {
                cell.contentTextField.text = @"女";
            }
        }
    }else {
        cell.titlelabel.text = @"年龄";
        cell.contentTextField.placeholder = @"宝宝多大了";
        if (self.babyInfoModel.age && self.babyInfoModel.age.length > 0) {
            cell.contentTextField.text = self.babyInfoModel.age;
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        action.tag = 1101;
        [action showInView:self.view];
    }else if (indexPath.row == 2) {
        TWJTimePickerView *timePicker = [[TWJTimePickerView alloc] initWithOkBtnTitle:@"确认" cancleBtnTitle:@"取消" delegate:self];
        timePicker.title = @"生日";
        [timePicker showInView:self.view.window];
        
    }
    
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        self.babyInfoModel.name = textField.text;
        [self.addTableview reloadData];
        
    }
    [textField resignFirstResponder];
    
}

#pragma mark - YDYTimeSelectPickViewDelegate
- (void)XKTimePickerView:(TWJTimePickerView *)timePickerView clickBtnAtIndex:(NSInteger)btnIndex timeData:(NSDate *)tiemData{
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setDateFormat:@"yyyy/MM/dd"];
    NSString *title = [df stringFromDate:tiemData];
    NSDate *bornDate=[df dateFromString:title];
    
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //创建日历(格里高利历)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置component的组成部分
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    //按照组成部分格式计算出生日期与现在时间的时间间隔
    NSDateComponents *date = [calendar components:unitFlags fromDate:bornDate toDate:currentDate options:0];
    
    NSString *age = [NSString stringWithFormat:@"%ld岁%ld月",(long)date.year,(long)date.month];
    self.babyInfoModel.age = age;
    [self.addTableview reloadData];
}

#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1100) {
        if (buttonIndex == 0) {
            UIImagePickerController* picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing=YES;
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }else if (buttonIndex == 1) {
            UIImagePickerController* picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing=YES;
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }else {
        if (buttonIndex == 0) {
            self.babyInfoModel.sex = @"1";
        }else if (buttonIndex == 1) {
            self.babyInfoModel.sex = @"0";
        }
        [self.addTableview reloadData];
    }
    
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image;
    if (picker.allowsEditing) {
        image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
    }else{
        image=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
    }
    self.addHeaderView.headerImageView.image = image;
    
    NSString *path_document = NSHomeDirectory();
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *datastr = [dataFormatter stringFromDate:[NSDate date]];
    NSString *namePath = [NSString stringWithFormat:@"/Documents/%@.png",datastr];
    NSString *imagePath = [path_document stringByAppendingString:namePath];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    self.babyInfoModel.icon = datastr;
    
}

@end

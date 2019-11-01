//
//  TWJNearHospitalViewController.m
//  TWJ
//
//  Created by ydd on 2019/7/24.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "TWJNearHospitalViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "TWJNearHospitalTableViewCell.h"
#import "TWJNearHospitalInfoModel.h"

@interface TWJNearHospitalViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    CLLocationManager *locationManager;
    
    CLLocation *currentLocation;
}
@property (nonatomic,strong)UITableView *nearHospitalTableView;
@property (nonatomic,strong)NSMutableArray *mapItemArray;

@end

@implementation TWJNearHospitalViewController

- (UITableView *)nearHospitalTableView {
    if (!_nearHospitalTableView) {
        _nearHospitalTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _nearHospitalTableView.delegate = self;
        _nearHospitalTableView.dataSource = self;
        _nearHospitalTableView.tableFooterView = [UIView new];
        _nearHospitalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _nearHospitalTableView;
}

- (NSMutableArray *)mapItemArray {
    if (!_mapItemArray) {
        _mapItemArray = [[NSMutableArray alloc] init];
    }
    return _mapItemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"附近医院";
    
    [self configSubviews];
    
    [self getUserLocation];
}

- (void)configSubviews {
    [super configSubviews];
    
    [self.view addSubview:self.nearHospitalTableView];
    [self.nearHospitalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

//获取位置
- (void)getUserLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 50.0f;
    CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
    
    //如果未授权则请求
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {//判断该软件是否开启定位
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"app需要获取您的位置，请先到设置->隐私->定位服务开启" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alertView.tag = 1;
        [alertView show];
    }else{
        if(status==kCLAuthorizationStatusNotDetermined) {
            [locationManager requestWhenInUseAuthorization];
        }
        //更新位置
        [locationManager startUpdatingLocation];
    }
}

#pragma mark-CLLocationManagerDelegate  位置更新后的回调

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止位置更新
    [locationManager stopUpdatingLocation];
    
    CLLocation *loc = [locations firstObject];
    //CLLocationCoordinate2D theCoordinate;
    //位置更新后的经纬度
    float lat = loc.coordinate.latitude;
    float lng = loc.coordinate.longitude;
    
    currentLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 2000, 2000);
    MKLocalSearchRequest * req = [[MKLocalSearchRequest alloc]init];
    req.region=region;
    req.naturalLanguageQuery=@"医院";
    
    MKLocalSearch * ser = [[MKLocalSearch alloc]initWithRequest:req];
    
    [ser startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        //兴趣点节点数组
        [self.mapItemArray removeAllObjects];
        
        NSArray * array = [NSArray arrayWithArray:response.mapItems];
        for (int i=0; i<array.count; i++) {

            MKMapItem * item=array[i];
            
            TWJNearHospitalInfoModel *model = [TWJNearHospitalInfoModel new];
            model.name = item.placemark.addressDictionary[@"Name"];
            model.address = [NSString stringWithFormat:@"%@",[item.placemark.addressDictionary[@"FormattedAddressLines"] firstObject]];
            CLLocation *beforeLocation = [[CLLocation alloc] initWithLatitude:item.placemark.coordinate.latitude longitude:item.placemark.coordinate.longitude];
            CLLocationDistance meters = [self->currentLocation distanceFromLocation:beforeLocation];
            model.distance = meters;
            model.mapitem = item;
            [self.mapItemArray addObject:model];
        }

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
        [self.mapItemArray sortUsingDescriptors:sortDescriptors];

        [self.nearHospitalTableView reloadData];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mapItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"TWJNearHospitalTableViewCell";
    TWJNearHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TWJNearHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TWJNearHospitalInfoModel * model = self.mapItemArray[indexPath.row];
    
    NSString *distance ;
    if (model.distance > 1000) {
        distance = [NSString stringWithFormat:@"%.2fkm",model.distance/1000];
    }else {
        distance = [NSString stringWithFormat:@"%.0fm",model.distance];
    }
    cell.distancelabel.text = distance;
    cell.nameLabel.text = model.name;
    cell.addressLabel.text = model.address;
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"百度地图", @"高德地图",@"腾讯地图",nil];
    actionSheet.tag = indexPath.row;
    [actionSheet showInView:self.view];
}


#pragma mark UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    TWJNearHospitalInfoModel * model = self.mapItemArray[actionSheet.tag];
    MKMapItem * item = model.mapitem;
    
    if (buttonIndex == 0) {//百度地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=位置&mode=driving&coord_type=gcj02",item.placemark.coordinate.latitude,item.placemark.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        } else {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"您的手机未安装百度地图，是否跳转至AppStore下载" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去下载", nil];
            alertview.tag = 1100;
            [alertview show];
        }
        
    }else if (buttonIndex == 1){//高德地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",item.placemark.coordinate.latitude,item.placemark.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"您的手机未安装高德地图，是否跳转至AppStore下载" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去下载", nil];
            alertview.tag = 1101;
            [alertview show];
        }
        
    }else if (buttonIndex == 2){//腾讯地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
            NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",item.placemark.coordinate.latitude,item.placemark.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else {
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"您的手机未安装腾讯地图，是否跳转至AppStore下载" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去下载", nil];
            alertview.tag = 1102;
            [alertview show];
        }
        
    }
}

#pragma mark  alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertView.tag == 1100) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/bai-du-tu-shou-ji-tu-lu-xian/id452186370?mt=8&v0=WWW-GCCN-ITSTOP100-FREEAPPS&l=&ign-mpt=uo%3D4"]];
        }else if (alertView.tag == 1101) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/gao-tu-zhuan-ye-shou-ji-tu/id461703208?mt=8"]];
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://url.cn/5t1aYRa"]];
        }
    }
    
}
@end

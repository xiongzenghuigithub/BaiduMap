

#import "OfflineViewController.h"

@interface OfflineViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation OfflineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    [self initMapView];
    [self initOfflineMap];
}

- (void)initTableView {

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
}

#pragma mark - BMKMapView init
- (void)initMapView {
    
    self.mapView = [[BMKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.mapView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    
    _offlineMap.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    
    _offlineMap.delegate = nil;
}

#pragma mark - 初始化离线地图
- (void)initOfflineMap {
    
    //初始化离线地图服务
    self.offlineMap = [[BMKOfflineMap alloc] init];
    
    //获取热门城市
    self.arrayHotCityData = [self.offlineMap getHotCityList];
    
    //获取支持离线下载城市列表
    self.arrayOfflineCityData = [self.offlineMap getOfflineCityList];
    
}

- (NSInteger)getCityIdByCityName:(NSString *)cityName {
    
    NSInteger cityID;
    
    //根据所给城市名查询到城市ID
    NSArray *cityArray = [self.offlineMap searchCity:cityName];
    if ([cityArray count] > 0) {
        
        //取出查询到得城市对象
        BMKOLSearchRecord* oneCity = [cityArray objectAtIndex:0];
        
        //从城市对象获取id
        cityID = [oneCity cityID];
    }
    
    return  cityID;
}

- (void)downloadOfflineMapByCityId:(NSInteger)cityId {
    
    //下载制定id的地图文件
    [_offlineMap start:cityId];
}

- (void)stopDownloadById:(NSInteger)cityId {
    
    [_offlineMap pause:cityId];
}

- (void)scanDownloadedMap {
    
    [_offlineMap scan:YES];
}

- (void)removeDownloadedMap:(NSInteger)cityId {
    
    [_offlineMap remove:cityId];
}

#pragma mark - 回调函数 接收到下载的离线地图 - 地图下载的各种回调状态处理
- (void)onGetOfflineMapState:(int)type withState:(int)state {
    
    if (type == TYPE_OFFLINE_UPDATE) {
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
    }
    if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }
    if (type == TYPE_OFFLINE_UNZIP) {
        //正在解压第state个离线包，导入时会回调此类型
    }
    if (type == TYPE_OFFLINE_ZIPCNT) {
        //检测到state个离线包，开始导入时会回调此类型
        NSLog(@"检测到%d个离线包",state);
        if(state==0)
        {
//            [self showImportMesg:state];
        }
    }
    if (type == TYPE_OFFLINE_ERRZIP) {
        //有state个错误包，导入完成后会回调此类型
        NSLog(@"有%d个离线包导入错误",state);
    }
    if (type == TYPE_OFFLINE_UNZIPFINISH) {
        NSLog(@"成功导入%d个离线包",state);
        //导入成功state个离线包，导入成功后会回调此类型
//        [self showImportMesg:state];
    }

}


@end

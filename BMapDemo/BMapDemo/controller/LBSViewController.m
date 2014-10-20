

#import "LBSViewController.h"

@interface LBSViewController () <BMKCloudSearchDelegate>

@end

@implementation LBSViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)initBMKCloudSearch {
    
    _search = _search = [[BMKCloudSearch alloc] init];
    _search.delegate = self;
}

- (void)startLocalCloudSearch {
    
    BMKCloudLocalSearchInfo *info = [[BMKCloudLocalSearchInfo alloc] init];
    
    //1. 设置申请的百度地图的 "服务端" ak
    info.ak = @"....";
    
    //2. 指定当前云检索请求向百度服务器上哪一张表进行查询 (1)表开发者自己创建 2)表中数据为开发者上传的检索结果数据)
    info.geoTableId = 3198;
    
    info.pageIndex = 0;
    info.pageSize = 10;
    
    info.region = @"北京市";
    info.keyword = @"小吃";
    
    //3. 发送云检索请求
    BOOL ret = [_search localSearchWithSearchInfo:info];
    
    if(ret){
        NSLog(@"本地云检索发送成功");
    }else{
        NSLog(@"本地云检索发送失败");
    }
}

- (void)startDetailSearchByUID:(int)uid {
    
    BMKCloudDetailSearchInfo *cloudDetailSearch = [[BMKCloudDetailSearchInfo alloc] init];
    cloudDetailSearch.ak = @"B266f735e43ab207ec152deff44fec8b";
    cloudDetailSearch.geoTableId = 31869;
    cloudDetailSearch.uid = @"19150264";
    BOOL flag = [_search detailSearchWithSearchInfo:cloudDetailSearch];

    if(flag){
        NSLog(@"详情云检索发送成功");
    }else{
        NSLog(@"详情云检索发送失败");
    }
}

#pragma mark - 返回云检索POI列表结果
- (void)onGetCloudPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error {
    
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    //请求结果正确
    if (error == BMKErrorOk) {
        
        //云检索结果list
        BMKCloudPOIList* result = [poiResultList objectAtIndex:0];
        
        //取出结果list中得每一个POI物体, 并显示在 BMKMapView
        for (int i = 0; i < result.POIs.count; i++) {
            
            //获取每一个具体的POI
            BMKCloudPOIInfo* poi = [result.POIs objectAtIndex:i];
            
            //每一个POI的uid
            int uid = [poi uid];
            
            //根据某一个UID发起详情检索
            [self startDetailSearchByUID:uid];
            
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc] init];
            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ poi.longitude,poi.latitude};
            item.coordinate = pt;
            item.title = poi.title;
            [_mapView addAnnotation:item];
        }
    } else {
        NSLog(@"error ==%d",error);
    }
}

#pragma mark - 返回云检索POI详情
- (void)onGetCloudPoiDetailResult:(BMKCloudPOIInfo*)poiDetailResult searchType:(int)type errorCode:(int)error {
    
    // 清除屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    if (error == BMKErrorOk) {
        BMKCloudPOIInfo* poi = poiDetailResult;
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc] init];
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ poi.longitude,poi.latitude};
        item.coordinate = pt;
        item.title = poi.title;
        [_mapView addAnnotation:item];
    } else {
        NSLog(@"error ==%d",error);
    }
}

@end

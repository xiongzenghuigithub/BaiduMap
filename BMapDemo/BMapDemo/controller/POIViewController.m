
#import "POIViewController.h"

@interface POIViewController () <BMKMapViewDelegate, BMKPoiSearchDelegate> {
    
    BMKPoiSearch *_search;
    
    NSInteger curPage;  //初始为显示第0页
}

@end

@implementation POIViewController

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
    
    [self initMapView];
}

- (void)initMapView {
    
    _mapView = [[BMKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _mapView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    
    _search.delegate = nil;
}

#pragma mark - 发起一个POI搜索

- (void)startPOISearch {
    
    //初始化检索对象
    _search = [[BMKPoiSearch alloc] init];
    _search.delegate = self;
    
    //构造搜索条件
    BMKNearbySearchOption *opt = [[BMKNearbySearchOption alloc] init];
    opt.pageIndex = curPage;
    opt.pageCapacity = 10;
    opt.location = CLLocationCoordinate2DMake(39.915, 116.404);
    opt.keyword = @"小吃";    //只当当前POI查询请求的搜索关键词
    
    //发送异步POI查询请求 （回调函数取得数据）
    BOOL ret = [_search poiSearchNearBy:opt];
    if (ret) {
        NSLog(@"周边检索发送成功");
    }else {
        NSLog(@"周边检索发送失败");
    }
}

#pragma mark - 回调函数 取得百度服务器发回的POI查询结果数据
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    
    if(errorCode == BMK_SEARCH_NO_ERROR){
        
        //do some thing...
    }
}



@end

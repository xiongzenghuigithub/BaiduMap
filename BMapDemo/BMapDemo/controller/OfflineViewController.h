
#import <UIKit/UIKit.h>

#import "BMKMapView.h"

@interface OfflineViewController : UIViewController <BMKMapViewDelegate, BMKOfflineMapDelegate>

@property (nonatomic, strong) BMKMapView * mapView;
@property (nonatomic, strong) BMKOfflineMap * offlineMap;
@property (nonatomic, strong) NSArray * arrayHotCityData;             //热门城市;
@property (nonatomic, strong) NSArray * arrayOfflineCityData;         //全国支持离线地图的城市
@property (nonatomic, strong) NSArray * arraylocalDownLoadMapInfo;    //本地下载的离线地图

@property (nonatomic, strong) UITableView *tableView;


/**
 *  根据城市名检索城市id
 */
- (NSInteger)getCityIdByCityName:(NSString *)cityName;

/**
 *  根据城市id下载离线包 -- 发送异步请求到百度服务器 -- 写请求回调函数接收相response数据
 */
- (void)downloadOfflineMapByCityId:(NSInteger)cityId;

/**
 *  停止下载指定城市id的离线包
 */
- (void)stopDownloadById:(NSInteger)cityId;

/**
 *  扫瞄离线包
 */
- (void)scanDownloadedMap;

/**
 *  删除本地离线包
 */
- (void)removeDownloadedMap:(NSInteger)cityId;

/**
 *  城市列表 / 下载管理切换
 */


@end



#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic, strong) BMKMapView *mapView;
/**
 *  在BMKMapView上添加 大头针
 */
- (void)addAnnotationViewWithLatitude:(float)latitude Longitude:(float)longitude Title:(NSString *)title addToMapView:(BMKMapView *)mapView;

/**
 *  移除 大头针
 */
- (void)removeAnnotation:(BMKPointAnnotation *)annotation fromMapView:(BMKMapView *)mapView;

/**
 *  在 BMKMapView上添加 折线覆盖物
 */
- (void)addPolylineWithFrom:(NSDictionary *)fromDict ToPoint:(NSDictionary *)toDict addToMapView:(BMKMapView *)mapView;

/**
 *  热力图操作
 */
-(void)addHeatMap;
-(void)removeHeatMap;

/**
 * 添加地形图层
 */
- (void)addLayer;

@end

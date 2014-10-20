
#import <UIKit/UIKit.h>

/**
 *  一个POI可以是一栋房子、一个商铺、一个邮筒、一个公交站等
 *  
 *  POI == 感兴趣的一个东西
 */

@interface POIViewController : UIViewController


@property (nonatomic, strong) BMKMapView *mapView;


/**
 *  发起一个POI搜索 -- (一个POI封装一个感兴趣要搜索的物体)
 */
- (void)startPOISearch;



@end

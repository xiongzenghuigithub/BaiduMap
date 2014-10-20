
#import <UIKit/UIKit.h>
/**
 *  LBS云检索步骤:
 *
 *      1) 数据存储: 开发者先将要查询到得结果数据存放到百度LBS数据管理平台
 *      2) 检索:    利用百度地图SDK为开发者提供的接口检索自己存放在百度的数据
 *      3) 展示:    开发者可根据自己的实际需求以多种形式（如结果列表、地图模式等）展现自己的数据
 *
 */

@interface LBSViewController : UIViewController


@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKCloudSearch *search;

/**
 *  初始化云检索
 */
- (void)initBMKCloudSearch;

/**
 *  发起本地云检索 -- 获取检索结果列表
 */
- (void)startLocalCloudSearch;


/**
 *  发起详情云检索 -- 根据选中的某一个结果进行详情检索
 */
- (void)startDetailSearchByUID:(int)uid;

@end

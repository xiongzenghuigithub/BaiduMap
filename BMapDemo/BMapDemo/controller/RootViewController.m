//
//  RootViewController.m
//  BMapDemo
//
//  Created by wadexiong on 14-10-16.
//  Copyright (c) 2014年 wadexiong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <BMKMapViewDelegate>

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"百度地图使用";
    
    [self initMapView];
    
    NSDictionary *dict1 = @{@"latitude":@"39.315", @"longitude":@"116.304"};
    NSDictionary *dict2 = @{@"latitude":@"39.515", @"longitude":@"116.504"};
    [self addPolylineWithFrom:dict1 ToPoint:dict2 addToMapView:self.mapView];
    
    [self addHeatMap];
    
    [self addLayer];
}

- (void)addAnnotationViewWithLatitude:(float)latitude Longitude:(float)longitude Title:(NSString *)title addToMapView:(BMKMapView *)mapView {
    
    //1. CLLocationCoordinate2D
    CLLocationCoordinate2D coor;
    coor.latitude = latitude;
    coor.longitude = longitude;
    
    //2. BMKAnnotation
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = coor;
    annotation.title = title;
    
    //3. 添加到BMKMapView
    [mapView addAnnotation:annotation];
}

- (void)removeAnnotation:(BMKPointAnnotation *)annotation fromMapView:(BMKMapView *)mapView {
    if (annotation != nil) {
        [_mapView removeAnnotation:annotation];
    }
}

- (void)addPolylineWithFrom:(NSDictionary *)fromDict ToPoint:(NSDictionary *)toDict addToMapView:(BMKMapView *)mapView {
    
//    CLLocationCoordinate2D coors[2] = {0};
//    coors[0].latitude = 39.315;
//    coors[0].longitude = 116.304;
//    coors[1].latitude = 39.515;
//    coors[1].longitude = 116.504;
//    BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
//    [_mapView addOverlay:polyline];

    
    
    CLLocationCoordinate2D coors[2] = {0};
//    coors[0].latitude = [[fromDict objectForKey:@"latitude"] floatValue];
//    coors[0].longitude = [[fromDict objectForKey:@"longitude"] floatValue];
//    coors[1].latitude = [[fromDict objectForKey:@"latitude"] floatValue];
//    coors[1].longitude = [[fromDict objectForKey:@"longitude"] floatValue];
    coors[0].latitude = 39.315;
    coors[0].longitude = 116.304;
    coors[1].latitude = 39.515;
    coors[1].longitude = 116.504;

    
    NSLog(@"coors[0]: %f - %f\n" ,coors[0].latitude, coors[0].longitude);
    NSLog(@"coors[1]: %f - %f\n" ,coors[1].latitude, coors[1].longitude);
    
    BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
    [mapView addOverlay:polyline];
}


-(void)addHeatMap{
    //创建热力图数据类
    BMKHeatMap* heatMap = [[BMKHeatMap alloc]init];
    //创建渐变色类
    UIColor* color1 = [UIColor blueColor];
    UIColor* color2 = [UIColor yellowColor];
    UIColor* color3 = [UIColor redColor];
    NSArray*colorInitialArray = [[NSArray alloc]initWithObjects:color1,color2,color3, nil];
    BMKGradient* gradient = [[BMKGradient alloc]initWithColors:colorInitialArray startPoints:@[@"0.08f", @"0.4f", @"1f"]];
    
    //如果用户自定义了渐变色则按自定义的渐变色进行绘制否则按默认渐变色进行绘制
    heatMap.mGradient = gradient;
    
    //创建热力图数据数组
    NSMutableArray* data = [NSMutableArray array];
    int num = 1000;
    for(int i = 0; i<num; i++)
    {
        //创建BMKHeatMapNode
        BMKHeatMapNode* heapmapnode_test = [[BMKHeatMapNode alloc]init];
        //此处示例为随机生成的坐标点序列，开发者使用自有数据即可
        CLLocationCoordinate2D coor;
        float random = (arc4random()%1000)*0.001;
        float random2 = (arc4random()%1000)*0.003;
        float random3 = (arc4random()%1000)*0.015;
        float random4 = (arc4random()%1000)*0.016;
        if(i%2==0){
            coor.latitude = 39.915+random;
            coor.longitude = 116.403+random2;
        }else{
            coor.latitude = 39.915-random3;
            coor.longitude = 116.403-random4;
        }
        heapmapnode_test.pt = coor;
        //随机生成点强度
        heapmapnode_test.intensity = arc4random()*900;
        //添加BMKHeatMapNode到数组
        [data addObject:heapmapnode_test];
        
    }
    //将点数据赋值到热力图数据类
    heatMap.mData = data;
    //调用mapView中的方法根据热力图数据添加热力图
    [_mapView addHeatMap:heatMap];
    
}

-(void)removeHeatMap{
    [_mapView removeHeatMap];
}

- (void)addLayer {
    
    [super viewDidLoad];
    //添加图片图层覆盖物(第一种:在指定经纬度添加图层)
    CLLocationCoordinate2D coords[2];
    coords[0].latitude = 39.800;
    coords[0].longitude = 116.404;
    BMKGroundOverlay* ground = [BMKGroundOverlay groundOverlayWithPosition:coords[0]
                                                                 zoomLevel:11 anchor:CGPointMake(0.0f,0.0f)
                                                                      icon:[UIImage imageNamed:@"test"]];
    [_mapView addOverlay:ground];
    
    //添加图片图层覆盖物(第二种:在指定region区域内填充图层)
    coords[0].latitude = 39.815;
    coords[0].longitude = 116.404;
    coords[1].latitude = 39.915;
    coords[1].longitude = 116.504;
    BMKCoordinateBounds bound;
    bound.southWest = coords[0];
    bound.northEast = coords[1];
    BMKGroundOverlay* ground2 = [BMKGroundOverlay groundOverlayWithBounds: bound
                                                                     icon:[UIImage imageNamed:@"test"]];
    [_mapView addOverlay:ground2];
}

#pragma mark - 初始化 BMKMapView 显示地图
- (void)initMapView {
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    [_mapView setMapType:BMKMapTypeStandard];
    self.view = _mapView;
}

#pragma mark - 控制 BMKMapView 的生命周期

//1) viewController即将显示时, 显示BMKMapView , 并设置代理 <BMKMapViewDelegate>
- (void)viewWillAppear:(BOOL)animated {
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

//2) viewController即将消失时, 移除BMKMapView , 并取消设置代理 <BMKMapViewDelegate>
- (void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

#pragma mark - BMKMapViewDelegate

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    float latitude = mapView.centerCoordinate.latitude;
    float longitude = mapView.centerCoordinate.longitude;
    
    [self addAnnotationViewWithLatitude:latitude Longitude:longitude Title:@"ahahahahah" addToMapView:self.mapView];
    
    NSLog(@"%f ----- %f\n" , latitude, longitude);
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

/**
 *  对添加到BMKMapView的基本对象进行单独判断，封装到对于的View中
 *
 *      1. BMKAnnotation ---> BMKAnnotationView
 *      2. BMKGroundOverlay ---> BMKGroundOverlayView 或 BMKPolylineView
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 5.0;
        
        return polylineView;
        
    }else if ([overlay isKindOfClass:[BMKGroundOverlay class]]) {
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
        return groundView;
    }
    
    return nil;
}

@end

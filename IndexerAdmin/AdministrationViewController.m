//
//  AdministrationViewController.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "AdministrationViewController.h"

@interface AdministrationViewController () {
    CLLocationManager * locationManager;
    UITapGestureRecognizer * tapMap;
    NSMutableArray * annotationArray;
    NSMutableArray * pointsCopy;
    NSMutableArray * points;
    MKPolygon * redZone;
}

@end

@implementation AdministrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    redZone = nil;
    points = [[NSMutableArray alloc] init];
    [zoneSelector setSelectedSegmentIndex:0];
    annotationArray = [[NSMutableArray alloc] init];
    
    mapView.showsUserLocation = YES;
    
    mapView.delegate = self;
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    
    tapMap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickMap)];
    [mapView addGestureRecognizer:tapMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    MKPolygonRenderer * mapZone = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    mapZone.alpha = 0.3;
    
    if (zoneSelector.selectedSegmentIndex == 0)
        mapZone.fillColor = [UIColor redColor];
    else if (zoneSelector.selectedSegmentIndex == 1)
        mapZone.fillColor = [UIColor yellowColor];
    else
        mapZone.fillColor = [UIColor greenColor];
    
    return mapZone;
}

- (void) onClickMap {
    if (redZone != nil) {
        [mapView removeOverlay:redZone];
    }

    CGPoint clickPoint = [tapMap locationInView:self.view];
    CLLocationCoordinate2D tapPoint = [mapView convertPoint:clickPoint toCoordinateFromView:self.view];
    
    MKPointAnnotation * marker = [[MKPointAnnotation alloc]init];
    marker.coordinate = tapPoint;
    [mapView addAnnotation:marker];
    
    [annotationArray addObject:marker];
    
    [points addObject:[NSValue valueWithMKCoordinate:tapPoint]];
    [self drawPolygone];
}

- (IBAction)deleteLast:(id)sender {
    if (points.count != 0) {
        [points removeObjectAtIndex:points.count-1];
        [mapView removeAnnotation:annotationArray.lastObject];
        [annotationArray removeLastObject];
        
        [mapView removeOverlay:redZone];
        [self drawPolygone];
    }
}

- (IBAction)clickZoneSelector:(id)sender {
    if (zoneSelector.selectedSegmentIndex == 1) {
        
    }
}

- (void) drawPolygone {
    pointsCopy = points.mutableCopy;
    
    CLLocationCoordinate2D * pointsCArray = malloc(sizeof(CLLocationCoordinate2D) * pointsCopy.count);
    for (int i = 0; i < points.count; i++) {
        pointsCArray[i] = [[points objectAtIndex:i] MKCoordinateValue];
    }
    
    if (pointsCopy.count >= 3) {
        redZone = [MKPolygon polygonWithCoordinates:pointsCArray count:points.count];
        free(pointsCArray);
        [mapView addOverlay:redZone];
    }
}

- (Zone *) saveZone:(MKPolygonRenderer *) aPolygon withColor:(UIColor *) polygonColor {
    Zone * newZone = [[Zone alloc] init];
    

    
    return newZone;
}


@end

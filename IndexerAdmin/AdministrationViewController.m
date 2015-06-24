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
    NSMutableArray * pointsCopy;
    NSMutableArray* points;
    MKPolygon * zone;
}

@end

@implementation AdministrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    zone = nil;
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    
    points = [[NSMutableArray alloc] init];

    tapMap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickMap)];
    [mapView addGestureRecognizer:tapMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    MKPolygonRenderer * renderer = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    renderer.strokeColor = [UIColor orangeColor];
    renderer.lineWidth = 3.0;
    return renderer;
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    mapView.showsUserLocation = YES;
}

- (void) onClickMap {
    if (zone != nil) {
        [mapView removeOverlay:zone];
    }
    
    CGPoint clickPoint = [tapMap locationInView:self.view];
    CLLocationCoordinate2D tapPoint = [mapView convertPoint:clickPoint toCoordinateFromView:self.view];
    
    MKPointAnnotation * annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = tapPoint;
    [mapView addAnnotation:annotation];
    
    [points addObject:[NSValue valueWithMKCoordinate:tapPoint]];
    pointsCopy = points.mutableCopy;
    
    CLLocationCoordinate2D * pointsCArray = malloc(sizeof(CLLocationCoordinate2D) * pointsCopy.count);
    for (int i = 0; i < points.count; i++) {
        pointsCArray[i] = [[points objectAtIndex:i] MKCoordinateValue];
    }

    if (pointsCopy.count >= 3) {
        zone = [MKPolygon polygonWithCoordinates:pointsCArray count:points.count];
        free(pointsCArray);
        [mapView addOverlay:zone];
    }
    
}

- (IBAction)deleteLast:(id)sender {
    if (points.count > 3) {
        [points removeObjectAtIndex:points.count-1];
        //[mapView removeAnnotation:mapView.annotations.lastObject-1];
        //[mapView removeAnnotation:mapView.annotations.count-1];
        //[mapView removeOverlay:zone];
    }
}

@end

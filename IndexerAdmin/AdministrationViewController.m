//
//  AdministrationViewController.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "AdministrationViewController.h"
#import "Administator.h"
#import "Zone.h"
#import "Note.h"
#import "AppDelegate.h"

@interface AdministrationViewController () {
    CLLocationManager * locationManager;
    UITapGestureRecognizer * tapMap;
    NSMutableArray * markerArray;
    
    NSMutableArray * polygonPoints;
    MKPolygon * polygon;
    Zone * zone;
}
@end

@implementation AdministrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    polygonPoints = [[NSMutableArray alloc] init];
    zone = [[Zone alloc] init];
    
    [self.zoneSelector setSelectedSegmentIndex:0];
    markerArray = [[NSMutableArray alloc] init];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    
    tapMap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickMap)];
    [self.mapView addGestureRecognizer:tapMap];
}

- (void) viewWillAppear:(BOOL)animated {
    [polygonPoints removeAllObjects];
    [markerArray removeAllObjects];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    self.zoneNameTF.text = nil;
    self.validateButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    MKPolygonRenderer * mapZone = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    mapZone.alpha = 0.3;
    
    if (self.zoneSelector.selectedSegmentIndex == 0)
        mapZone.fillColor = [UIColor redColor];
    else if (self.zoneSelector.selectedSegmentIndex == 1)
        mapZone.fillColor = [UIColor yellowColor];
    else
        mapZone.fillColor = [UIColor greenColor];
    
    return mapZone;
}

- (void) onClickMap {
    
    CGPoint clickPoint = [tapMap locationInView:self.view];
    CLLocationCoordinate2D tapPoint = [self.mapView convertPoint:clickPoint toCoordinateFromView:self.view];
    
    MKPointAnnotation * marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = tapPoint;
    [self.mapView addAnnotation:marker];
    [markerArray addObject:marker];
    
    Coordinates * newCoordinate = [[Coordinates alloc] init];
    newCoordinate.longitude = [NSString stringWithFormat:@"%f", tapPoint.longitude];
    newCoordinate.latitude = [NSString stringWithFormat:@"%f", tapPoint.latitude];
    
    if (polygon != nil)
        [self.mapView removeOverlay:polygon];
    
    [polygonPoints addObject:[NSValue valueWithMKCoordinate:tapPoint]];
    polygon = [self drawPolygone:polygonPoints];
    [zone.pointsData addObject:newCoordinate];
}

- (IBAction)deleteLast:(id)sender {
    if (polygonPoints.count != 0) {
        [polygonPoints removeObjectAtIndex:polygonPoints.count-1];
        [self.mapView removeAnnotation:markerArray.lastObject];
        [markerArray removeLastObject];
        
        [self.mapView removeOverlay:polygon];
        polygon = [self drawPolygone:polygonPoints];
    }
}

- (IBAction)clickValidateButton:(id)sender {
    if (![self.zoneNameTF.text isEqual:nil] && polygon != nil) {
        if (self.zoneSelector.selectedSegmentIndex == 0)
            zone.zoneColor = @"RED";
        else if (self.zoneSelector.selectedSegmentIndex == 1)
            zone.zoneColor = @"YELLOW";
        else if (self.zoneSelector.selectedSegmentIndex == 2)
            zone.zoneColor = @"GREEN";
        
        zone.perimeter = [self parseTab:zone.pointsData];
        zone.zoneName = self.zoneNameTF.text;
        [zone createZone:self];
    }
}

- (IBAction)clickZoneSelector:(id)sender {
}

- (MKPolygon*) drawPolygone:(NSArray *) polygonePoints {
    MKPolygon* polygone = nil;
    
    CLLocationCoordinate2D * coordinatesPoints = malloc(sizeof(CLLocationCoordinate2D) * polygonePoints.count);
    for (int i = 0; i < polygonePoints.count; i++) {
        coordinatesPoints[i] = [[polygonePoints objectAtIndex:i] MKCoordinateValue];
    }
    
    if (polygonePoints.count >= 3) {
        polygone = [MKPolygon polygonWithCoordinates:coordinatesPoints count:polygonePoints.count];
        [self.mapView addOverlay:polygone];
    }
    
    free(coordinatesPoints);
    return polygone;
}

- (IBAction)clickZonesButton:(id)sender {
    [self performSegueWithIdentifier:@"goToZones" sender:self];
}

- (IBAction)clickZoneNameTF:(id)sender {
    self.validateButton.enabled = YES;
}

- (NSString *) parseTab:(NSArray *) aTab {
    NSString * stringFinal = @"[";
    
    for (int i = 0; i < aTab.count; i ++) {
        Coordinates *coord = [aTab objectAtIndex:i];
        NSString* virgule;
        if(i == (aTab.count - 1)){
            virgule = @"]";
        }
        else{
            virgule = @",";
        }
        stringFinal = [stringFinal stringByAppendingString:[NSString stringWithFormat:@"{ \"long\" : %@, \"lat\" : %@}%@", coord.longitude, coord.latitude, virgule]];
    }
    
    NSLog(@"String finale: %@", stringFinal);
    return stringFinal;
}

#pragma mark Zone Protocole

- (void) zoneCreated {

}

- (void) getZone:(id)zone {
    
}

- (void) getAllZones:(NSMutableArray *) allZones{
    
}

@end

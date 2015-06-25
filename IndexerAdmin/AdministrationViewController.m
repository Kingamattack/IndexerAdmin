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
    
    NSMutableArray * redPoints;
    MKPolygon * redPolygon;
    Zone * redZone;
    
    NSMutableArray * yellowPoints;
    MKPolygon * yellowPolygon;
    Zone * yellowZone;
    
    NSMutableArray * greenPoints;
    MKPolygon * greenPolygon;
    Zone * greenZone;
}
@end

@implementation AdministrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    redZone = [[Zone alloc] init];
    yellowZone = [[Zone alloc] init];
    greenZone = [[Zone alloc] init];
    
    redPoints = [[NSMutableArray alloc] init];
    yellowPoints = [[NSMutableArray alloc] init];
    greenPoints = [[NSMutableArray alloc] init];
    
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
    
    if (self.zoneSelector.selectedSegmentIndex == 0) {
        if (redPolygon != nil)
            [self.mapView removeOverlay:redPolygon];
        
        [redPoints addObject:[NSValue valueWithMKCoordinate:tapPoint]];
        redPolygon = [self drawPolygone:redPoints];
        [redZone.pointsData addObject:newCoordinate];
        NSLog(@"RED: %@", [redZone.pointsData objectAtIndex:0]);
    }
    else if (self.zoneSelector.selectedSegmentIndex == 1) {
        if (yellowPolygon != nil)
            [self.mapView removeOverlay:yellowPolygon];
        
        [yellowPoints addObject:[NSValue valueWithMKCoordinate:tapPoint]];
        yellowPolygon = [self drawPolygone:yellowPoints];
         [yellowZone.pointsData addObject:newCoordinate];
    }
    else {
        if (greenPolygon != nil)
            [self.mapView removeOverlay:greenPolygon];
        
        [greenPoints addObject:[NSValue valueWithMKCoordinate:tapPoint]];
        greenPolygon = [self drawPolygone:greenPoints];
         [greenZone.pointsData addObject:newCoordinate];
    }
}

- (IBAction)deleteLast:(id)sender {
    
    if (self.zoneSelector.selectedSegmentIndex == 0) {
        if (redPoints.count != 0) {
            [redPoints removeObjectAtIndex:redPoints.count-1];
            [self.mapView removeAnnotation:markerArray.lastObject];
            [markerArray removeLastObject];

            [self.mapView removeOverlay:redPolygon];
            redPolygon = [self drawPolygone:redPoints];
        }
    } else if (self.zoneSelector.selectedSegmentIndex == 1) {
        if (yellowPoints.count != 0) {
            [yellowPoints removeObjectAtIndex:yellowPoints.count-1];
            [self.mapView removeAnnotation:markerArray.lastObject];
            [markerArray removeLastObject];
            
            [self.mapView removeOverlay:yellowPolygon];
            yellowPolygon = [self drawPolygone:yellowPoints];
        }
    } else if (self.zoneSelector.selectedSegmentIndex == 2){
        if (greenPoints.count != 0) {
            [greenPoints removeObjectAtIndex:greenPoints.count-1];
            [self.mapView removeAnnotation:markerArray.lastObject];
            [markerArray removeLastObject];
            
            [self.mapView removeOverlay:greenPolygon];
            greenPolygon = [self drawPolygone:greenPoints];
        }
    }
}

- (IBAction)clickValidateButton:(id)sender {
    if (self.zoneSelector.selectedSegmentIndex == 0) {
        if (redPolygon != nil) {
            redZone.zoneColor = @"RED";
            redZone.perimeter = [self parseTab:redZone.pointsData];
            [redZone createZone];
        }
    }else if (self.zoneSelector.selectedSegmentIndex == 1) {
        if (yellowPolygon != nil) {
            yellowZone.zoneColor = @"YELLOW";
            yellowZone.perimeter = [self parseTab:yellowZone.pointsData];
            [yellowZone createZone];
        }
    } else if (self.zoneSelector.selectedSegmentIndex == 2) {
        if (greenPolygon != nil) {
            greenZone.zoneColor = @"GREEN";
            greenZone.perimeter = [self parseTab:greenZone.pointsData];
            [greenZone createZone];
        }
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

/* ----------------- CALLBACK PROTOCOL ------------------ */

- (void)getZone:(id)zone {
    self.zoneNeeded = (Zone *)zone;
}

- (void)getNote:(id)note{
    self.noteNeeded = (Note *)note;
}

- (void) getNoteList:(NSMutableArray *)notes{
    self.user.notes = notes;
}

/* --------------- END CALLBACK PROTOCOL ---------------- */
    
@end

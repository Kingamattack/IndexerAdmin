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
    NSMutableArray * markerArray;
    
    NSMutableArray * polygonPoints;
    MKPolygon * polygon;
    Zone * zone;
    
    NSArray * mapMode;
}
@end

@implementation AdministrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Check if the polygon exist
    if (polygon == nil) {
        
        polygonPoints = [[NSMutableArray alloc] init];
        markerArray = [[NSMutableArray alloc] init];
        zone = [[Zone alloc] init];
        
        // Check up the second Toggle Button
        [self.zoneSelector setSelectedSegmentIndex:0];
        
        // Initialize the mapView for userlocation
        self.mapView.showsUserLocation = YES;
        self.mapView.delegate = self;
        
        // Initialize the Manager to manage the location
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
        
        // Bind the map with the TapGesture
        tapMap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickMap)];
        [self.mapView addGestureRecognizer:tapMap];
    }else
        polygon = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MapView

- (void)onClickMap {
    
    // Create a CLLocationCoordinate2D where the user clicked on the map
    CGPoint clickPoint = [tapMap locationInView:self.view];
    CLLocationCoordinate2D tapPoint = [self.mapView convertPoint:clickPoint toCoordinateFromView:self.view];
    
    // Create and display a Annotation(marker) where the user clicked on the map
    MKPointAnnotation * marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = tapPoint;
    
    // Add a marker on the map and in a Array
    [self.mapView addAnnotation:marker];
    [markerArray addObject:marker];
    
    // Create a coordinate where the user clicked on the map
    Coordinates * newCoordinate = [[Coordinates alloc] init];
    newCoordinate.longitude = [NSString stringWithFormat:@"%f", tapPoint.longitude];
    newCoordinate.latitude = [NSString stringWithFormat:@"%f", tapPoint.latitude];
    
    // Create the polygon with the points in the table
    // Create a Zone object wich have the sames coordinates that the polygon
    if (polygon != nil)
        [self.mapView removeOverlay:polygon];
    
    [polygonPoints addObject:[NSValue valueWithMKCoordinate:tapPoint]];
    polygon = [self drawPolygone:polygonPoints];
    [zone.pointsData addObject:newCoordinate];
}

- (MKPolygon*) drawPolygone:(NSArray *)polygonePoints {
    MKPolygon* polygone = nil;
    
    // Save the coordinates create by the user click
    CLLocationCoordinate2D * coordinatesPoints = malloc(sizeof(CLLocationCoordinate2D) * polygonePoints.count);
    for (int i = 0; i < polygonePoints.count; i++) {
        coordinatesPoints[i] = [[polygonePoints objectAtIndex:i] MKCoordinateValue];
    }
    
    // Create and add a polygon on the map when there are at least 3 points
    if (polygonePoints.count >= 3) {
        polygone = [MKPolygon polygonWithCoordinates:coordinatesPoints count:polygonePoints.count];
        [self.mapView addOverlay:polygone];
    }
    
    free(coordinatesPoints);
    return polygone;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    
    // Draw on the map the previous polygon
    MKPolygonRenderer * mapZone = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    mapZone.alpha = 0.3;
    
    // Change the polygon color by checking the selected segment
    if (self.zoneSelector.selectedSegmentIndex == 0)
        mapZone.fillColor = [UIColor redColor];
    else if (self.zoneSelector.selectedSegmentIndex == 1)
        mapZone.fillColor = [UIColor yellowColor];
    else
        mapZone.fillColor = [UIColor greenColor];
    
    return mapZone;
}

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}

#pragma mark Bouttons

- (IBAction)deleteLast:(id)sender {
    
    // Check if the polygon exist
    if (polygonPoints.count != 0) {
        
        // Remove the last point of all the table bind to the polygon (marker, zone table)
        [polygonPoints removeObjectAtIndex:polygonPoints.count-1];
        [self.mapView removeAnnotation:markerArray.lastObject];
        [markerArray removeLastObject];
        [zone.pointsData removeLastObject];
        
        // Delete the polygon from the map and redraw it
        [self.mapView removeOverlay:polygon];
        polygon = [self drawPolygone:polygonPoints];
    }
}

- (IBAction)clickValidateButton:(id)sender {
    
    // Check if the polygon got a name, a color and at least 3 points
    if (self.zoneNameTF.text.length < 1 || polygon == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Erreur création"
                                                         message:@"Zone incomplete." delegate:nil
                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else {
        if (self.zoneSelector.selectedSegmentIndex == 0)
            zone.zoneColor = @"RED";
        else if (self.zoneSelector.selectedSegmentIndex == 1)
            zone.zoneColor = @"YELLOW";
        else if (self.zoneSelector.selectedSegmentIndex == 2)
            zone.zoneColor = @"GREEN";
        
        // Create a Zone object and send it to the server
        zone.perimeter = [self parseTab:zone.pointsData];
        zone.zoneName = self.zoneNameTF.text;
        [zone createZone:self];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Création zone"
                                                         message:[NSString stringWithFormat:@"Zone %@ créee.", zone.zoneName]
                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        // Go to the next page and clear all the fields (text, tables...)
        [self performSegueWithIdentifier:@"goToZones" sender:self];
        
        [polygonPoints removeAllObjects];
        [markerArray removeAllObjects];
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView removeOverlays:self.mapView.overlays];
        [zone.pointsData removeAllObjects];
        
        self.zoneNameTF.text = nil;
        self.validateButton.enabled = NO;
    }
}

- (IBAction)clickZoneSelector:(id)sender {
}

- (IBAction)clickZonesButton:(id)sender {
    [self performSegueWithIdentifier:@"goToZones" sender:self];
}

- (IBAction)clickZoneNameTF:(id)sender {
    self.validateButton.enabled = YES;
}

- (NSString *)parseTab:(NSArray *)aTab {
    
    // Change the given table in a String by appending each object
    NSString * stringFinal = @"[";
    
    for (int i = 0; i < aTab.count; i ++) {
        Coordinates * coord = [aTab objectAtIndex:i];
        NSString * virgule;
        if(i == (aTab.count - 1)){
            virgule = @"]";
        }
        else{
            virgule = @",";
        }
        stringFinal = [stringFinal stringByAppendingString:[NSString stringWithFormat:@"{ \"long\" : %@, \"lat\" : %@}%@", coord.longitude, coord.latitude, virgule]];
    }
    
    return stringFinal;
}

@end

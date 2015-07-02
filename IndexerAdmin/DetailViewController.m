//
//  DetailViewController.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 26/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    MKPolygon * polygon;
    NSMutableArray * noteArray;
    NSMutableArray * polygonPoints;
    Note * note;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Check the zone status (enable, disable) and update the 'deleteButton' title
    if ([self.selectedZone.used isEqual:@0]) {
        [self.disableButton setTitle:@"Activer zone" forState:UIControlStateNormal];
        [self.disableButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    
    // Manager the user location
    self.zoneMapView.showsUserLocation = YES;
    self.zoneMapView.delegate = self;
    
    noteArray = [[NSMutableArray alloc] init];
    polygonPoints = [[NSMutableArray alloc] init];
    polygon = [self drawPolygone:polygonPoints];
    self.zoneNameTF.text = self.selectedZone.zoneName;
    [self zoomToFitMapAnnotations];
    
    // Get the notes bind to the selected zone
    [Note getAllNotesFromZone:self.selectedZone.zoneID sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [noteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *aCell = (NoteTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"noteID" forIndexPath:indexPath];
    
    Note * aNote = [noteArray objectAtIndex:indexPath.row];
    aCell.noteZoneName.text = aNote.noteName;
    aCell.noteZoneContent.text = aNote.content;

    return aCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Notes de la zone";
}

#pragma Map Protocole

- (MKPolygon*)drawPolygone:(NSMutableArray *)polygonePoints {
    MKPolygon* polygone = nil;
    
    // Save the coordinates create by the user click
    CLLocationCoordinate2D * coordinatesPoints = malloc(sizeof(CLLocationCoordinate2D) * self.selectedZone.pointsData.count);
    
    for (int i = 0; i < self.selectedZone.pointsData.count; i++) {
        Coordinates * newCoordinates = [self.selectedZone.pointsData objectAtIndex:i];
        
        CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(newCoordinates.latitude.floatValue, newCoordinates.longitude.floatValue);
        MKPointAnnotation * marker = [[MKPointAnnotation alloc] init];
        marker.coordinate = coordinate2D;
        
        coordinatesPoints[i] = coordinate2D;
        [polygonePoints addObject:[NSValue valueWithMKCoordinate:coordinate2D]];
        [self.zoneMapView addAnnotation:marker];
    }
    
    // Create and add a polygon on the map when there are at least 3 points
    polygon = [MKPolygon polygonWithCoordinates:coordinatesPoints count:polygonePoints.count];
    [self.zoneMapView addOverlay:polygon];
    
    free(coordinatesPoints);
    return polygone;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    
    // Draw on the map the previous polygon
    MKPolygonRenderer * mapZone = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    mapZone.alpha = 0.3;
    
    // Change the polygon color by checking the selected segment
    if ([self.selectedZone.zoneColor isEqualToString:@"RED"])
        mapZone.fillColor = [UIColor redColor];
    else if ([self.selectedZone.zoneColor isEqualToString:@"YELLOW"])
        mapZone.fillColor = [UIColor yellowColor];
    else
        mapZone.fillColor = [UIColor greenColor];
    
    return mapZone;
}

- (void)zoomToFitMapAnnotations {
    
    // Check if there are annotations on the map
    if([self.zoneMapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(MKPointAnnotation * annotation in self.zoneMapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [self.zoneMapView regionThatFits:region];
    [self.zoneMapView setRegion:region animated:YES];
}

#pragma Boutons

- (IBAction)clickUpdateButton:(id)sender {
    if (self.updateButton.titleLabel.text.length > 1) {
        
        self.selectedZone.zoneName = self.zoneNameTF.text;
        [self.selectedZone updateZone];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Modification zone"
                                                         message:[NSString stringWithFormat:@"Zone %@ modifiée.", self.selectedZone.zoneName]
                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)clickDisableButton:(id)sender {
    
    if ([self.selectedZone.used isEqual:@0])
        [self.selectedZone enableZone:self];
    else
        [self.selectedZone disableZone:self];
    
}

#pragma Zone Protocole

- (void)zoneWasDisable:(BOOL)statut {
    UIAlertView * alert;
    
    if (statut) {
        alert = [[UIAlertView alloc] initWithTitle:@"Désactivation zone"
                                           message:[NSString stringWithFormat:@"Zone %@ désactivée.", self.selectedZone.zoneName]
                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)zoneWasEnable:(BOOL)statut {
    UIAlertView * alert;
    
    if (statut) {
        alert = [[UIAlertView alloc] initWithTitle:@"Activation zone"
                                           message:[NSString stringWithFormat:@"Zone %@ activée.", self.selectedZone.zoneName]
                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }    
}

- (void)didDownloadNoteListFromZone:(NSMutableArray *)allNotes {
    
    for (int i = 0; i < [allNotes count]; i++) {
        Note * newNote = [allNotes objectAtIndex:i];
        [noteArray addObject:newNote];
    }
    
    [self.noteTableView reloadData];
}

#pragma mark Note Protocole

- (void)noteListWasGetting:(NSMutableArray *)notes {
    
}

- (void)getAllZones:(NSMutableArray *)allZones {
    
}

- (void)zoneWasGetting:(id)zone {
    
}

- (void)getNote:(id)note {
    
}

- (void)zoneCreated {
    
}


@end

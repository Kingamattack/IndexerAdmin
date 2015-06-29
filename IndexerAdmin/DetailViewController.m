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
    
    noteArray = [[NSMutableArray alloc] init];
    polygonPoints = [[NSMutableArray alloc] init];
    polygon = [self drawPolygone:polygonPoints];
    self.zoneNameTF.text = self.selectedZone.zoneName;
    [Note getAllNotesFromZone:self.selectedZone.zoneID sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [noteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *aCell = (NoteTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"noteID" forIndexPath:indexPath];
    
    Note * aNote = [noteArray objectAtIndex:indexPath.row];
    aCell.noteZoneName.text = aNote.noteName;
    aCell.noteZoneContent.text = aNote.content;
    //aCell.separatorView.layer.frame.size.width = aCell.noteZoneName.layer.frame.size.width;

    return aCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Notes de la zone";
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    MKPolygonRenderer * mapZone = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    mapZone.alpha = 0.3;
    
    if ([self.selectedZone.zoneColor isEqualToString:@"RED"])
        mapZone.fillColor = [UIColor redColor];
    else if ([self.selectedZone.zoneColor isEqualToString:@"YELLOW"])
        mapZone.fillColor = [UIColor yellowColor];
    else
        mapZone.fillColor = [UIColor greenColor];
    
    return mapZone;
}

- (MKPolygon*) drawPolygone:(NSMutableArray *) polygonePoints {
    MKPolygon* polygone = nil;
    
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
    
    polygon = [MKPolygon polygonWithCoordinates:coordinatesPoints count:polygonePoints.count];
    [self.zoneMapView addOverlay:polygon];
 
    free(coordinatesPoints);
    return polygone;
}

- (IBAction)clickUpdateButton:(id)sender {
    //if ([self.updateButton.titleLabel.text isEqualToString:@"Modifier"]) {
        
        NSLog(@"Je suis là");
        self.selectedZone.zoneName = self.zoneNameTF.text;
        [self.selectedZone updateZone];
   // }
    
}

- (IBAction)clickDeleteButton:(id)sender {
    [self.selectedZone disableZone];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Suppression zone"
                                                     message:[NSString stringWithFormat:@"Zone %@ supprimée.", self.selectedZone.zoneName]
                                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) getNote:(id)note {
    
}

- (void) getNoteList:(NSMutableArray*)notes {
    
}

- (void) didDownloadNoteListFromZone:(NSMutableArray *)allNotes {

    NSLog(@" NOTEQ: %lu", (unsigned long)allNotes.count);
    
    for (int i = 0; i < [allNotes count]; i++) {
        Note * newNote = [allNotes objectAtIndex:i];
        [noteArray addObject:newNote];
    }
    
    [self.noteTableView reloadData];
}

@end

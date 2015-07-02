//
//  DetailViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 26/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "Note.h"
#import "Zone.h"
#import <UIKit/UIKit.h>
#import "Administator.h"
#import <MapKit/MapKit.h>
#import "NoteTableViewCell.h"
#import <CoreLocation/CoreLocation.h>


@interface DetailViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, NoteManagement, ZoneManagement>

@property Zone * selectedZone;
@property (strong, nonatomic) IBOutlet UIButton * disableButton;
@property (strong, nonatomic) IBOutlet UITableView * noteTableView;
@property (strong, nonatomic) IBOutlet MKMapView * zoneMapView;
@property (strong, nonatomic) IBOutlet UIButton * updateButton;
@property (strong, nonatomic) IBOutlet UITextField * zoneNameTF;

/**
 *
 *  Update the zone name
 *
 **/
- (IBAction)clickUpdateButton:(id)sender;

/**
 *
 *  Disable/Enable a zone
 *
 **/
- (IBAction)clickDisableButton:(id)sender;

/**
 *
 *  Draw a polygon with the coordinates in the Array
 *  @param (NSArrray) Array with the coordinates of the area
 *  @return (MKPolygon) Polygon draw by the function
 *
 **/
- (MKPolygon *)drawPolygone:(NSMutableArray *)polygonePoints;

/**
 *
 *  Zoom automatically on the zone region
 *
 **/
- (void)zoomToFitMapAnnotations;

@end

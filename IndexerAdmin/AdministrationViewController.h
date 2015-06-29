//
//  AdministrationViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Administator.h"
#import "Zone.h"
#import "Note.h"

@interface AdministrationViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, ZoneManagement>


@property IBOutlet MKMapView * mapView;
@property IBOutlet UISegmentedControl * zoneSelector;
@property (strong, nonatomic) IBOutlet UITextField * zoneNameTF;
@property (strong, nonatomic) IBOutlet UIButton * validateButton;

- (IBAction)deleteLast:(id)sender;
- (IBAction)clickValidateButton:(id)sender;
- (IBAction)clickZoneSelector:(id)sender;
- (IBAction)clickZonesButton:(id)sender;
- (IBAction)clickZoneNameTF:(id)sender;

- (MKPolygon*) drawPolygone:(NSArray *) polygonePoints;


@end

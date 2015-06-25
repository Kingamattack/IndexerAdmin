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


@interface AdministrationViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, ZoneManagement, NoteManagement>

@property IBOutlet MKMapView *mapView;
@property Administator *user;
@property Zone* zoneNeeded;
@property Note* noteNeeded;

- (IBAction)deleteLast:(id)sender;

@end

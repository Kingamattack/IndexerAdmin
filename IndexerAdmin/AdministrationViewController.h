//
//  AdministrationViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "Zone.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AdministrationViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    IBOutlet MKMapView *mapView;
    IBOutlet UISegmentedControl *zoneSelector;
}

- (IBAction)deleteLast:(id)sender;
- (IBAction)clickZoneSelector:(id)sender;

@end

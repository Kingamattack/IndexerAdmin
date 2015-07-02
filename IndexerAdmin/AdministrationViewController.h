//
//  AdministrationViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "Zone.h"
#import "Note.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Administator.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AdministrationViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, ZoneManagement>


@property IBOutlet MKMapView * mapView;
@property IBOutlet UISegmentedControl * zoneSelector;
@property (strong, nonatomic) IBOutlet UITextField * zoneNameTF;
@property (strong, nonatomic) IBOutlet UIButton * validateButton;

/**
 *
 *  Delete the last drawed point/marker on the map
 *
 */
- (IBAction)deleteLast:(id)sender;

/**
 *
 *  Create the zone and send it to the server
 *
 */
- (IBAction)clickValidateButton:(id)sender;

/**
 *
 *  Select the zone color
 *
 */
- (IBAction)clickZoneSelector:(id)sender;

/**
 *
 *  Go to list of the zones
 *
 */
- (IBAction)clickZonesButton:(id)sender;

/**
 *
 *  TextField to name the zone
 *
 */
- (IBAction)clickZoneNameTF:(id)sender;

/**
 *
 *  Provide to bind the click on the screen to the click on the map.
 *  Show a marker at the click location
 *
 **/
- (void)onClickMap;

/**
 *
 *  Draw a polygon with the coordinates in the Array
 *  @param (NSArrray) Array with the coordinates of the area
 *  @return (MKPolygon) Polygon draw by the function
 *
 **/
- (MKPolygon*)drawPolygone:(NSArray *)polygonePoints;

/**
 *
 *  Parse the Array into a String
 *  @param (NSArrray) Array wich will be changed into a string
 *  @return (NSString) String generated with the Array
 *
 **/
- (NSString *)parseTab:(NSArray *)aTab;


@end

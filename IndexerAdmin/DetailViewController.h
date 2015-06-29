//
//  DetailViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 26/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NoteTableViewCell.h"
#import "Administator.h"
#import "Zone.h"

@interface DetailViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, NoteManagement>

@property Zone * selectedZone;
@property (strong, nonatomic) IBOutlet UITableView * noteTableView;
@property (strong, nonatomic) IBOutlet MKMapView * zoneMapView;
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UITextField *zoneNameTF;

- (IBAction)clickUpdateButton:(id)sender;
- (IBAction)clickDeleteButton:(id)sender;

- (MKPolygon*) drawPolygone:(NSMutableArray *) polygonePoints;

@end

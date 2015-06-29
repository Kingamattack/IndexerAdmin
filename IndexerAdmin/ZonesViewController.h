//
//  ZonesViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 26/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Zone.h"
#import "Note.h"
#import "Administator.h"
#import "DetailViewController.h"

@interface ZonesViewController : UIViewController <ZoneManagement, UITableViewDataSource, UITableViewDelegate>


@property Administator * user;
@property Zone * zoneNeeded;
@property Note * noteNeeded;
@property (strong, nonatomic) IBOutlet UITableView * zonesTableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl * zoneStateSelector;

- (IBAction)clickZoneStateSelector:(id)sender;

@end

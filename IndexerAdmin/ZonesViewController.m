//
//  ZonesViewController.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 26/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "ZonesViewController.h"

@interface ZonesViewController () {
    NSMutableArray * zoneArray;
    NSMutableArray * zoneDisplay;
}
@end


@implementation ZonesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    zoneArray = [[NSMutableArray alloc] init];
    zoneDisplay = [[NSMutableArray alloc] init];
}

- (void) viewWillAppear:(BOOL)animated {
    
    // Clear all the data and reload them
    [self.zoneStateSelector setSelectedSegmentIndex:1];
    [zoneArray removeAllObjects];
    [Zone getAllZonesWithSender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [zoneDisplay count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * aCell = [tableView dequeueReusableCellWithIdentifier:@"zoneCell" forIndexPath:indexPath];
    
    Zone * aZone = [zoneDisplay objectAtIndex:indexPath.row];
    aCell.textLabel.text = aZone.zoneName; 
    aCell.detailTextLabel.text = aZone.zoneColor;
    
    return aCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Liste des zones";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController * destinationSegue = segue.destinationViewController;
    
    NSUInteger selectedRow = self.zonesTableView.indexPathForSelectedRow.row;
    destinationSegue.selectedZone = [zoneDisplay objectAtIndex:selectedRow];
}

#pragma mark Zone Protocole

- (void)zoneWasGetting:(id)zone {
    self.zoneNeeded = (Zone *)zone;
}

- (void)getAllZones:(NSMutableArray *)allZones{
    
    [zoneDisplay removeAllObjects];
    [zoneArray removeAllObjects];
    
    // Display the enables Zones and display them in the TableView
    for (int i = 0; i < allZones.count; i++) {
        Zone * newZone = [allZones objectAtIndex:i];
        [zoneArray addObject:newZone];
        if ([newZone.used isEqual:@1])
            [zoneDisplay addObject:newZone];
    }
    
    [self.zonesTableView reloadData];
}

- (IBAction)clickZoneStateSelector:(id)sender {
    [zoneDisplay removeAllObjects];
    
    // Change the displaied zones by them status (enable, disable)
    if (self.zoneStateSelector.selectedSegmentIndex == 2) {
        for (int i = 0; i < zoneArray.count; i ++) {
            if ([[[zoneArray objectAtIndex:i] used] isEqual:@0])
                [zoneDisplay addObject:[zoneArray objectAtIndex:i]];
        }
        
    }else if (self.zoneStateSelector.selectedSegmentIndex == 1) {
        for (int i = 0; i < zoneArray.count; i ++) {
            if ([[[zoneArray objectAtIndex:i] used] isEqual:@1])
                [zoneDisplay addObject:[zoneArray objectAtIndex:i]];
        }
    }else
        [zoneDisplay addObjectsFromArray:zoneArray];

    [self.zonesTableView reloadData];
}

@end

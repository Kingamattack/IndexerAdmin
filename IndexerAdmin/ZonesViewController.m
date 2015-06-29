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
}
@end


@implementation ZonesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.zoneStateSelector setSelectedSegmentIndex:1];
    zoneArray = [[NSMutableArray alloc] init];
}

- (void) viewWillAppear:(BOOL)animated {
    [zoneArray removeAllObjects];
    [Zone getAllZonesWithSender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [zoneArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * aCell = [tableView dequeueReusableCellWithIdentifier:@"zoneCell" forIndexPath:indexPath];
    
    Zone * aZone = [zoneArray objectAtIndex:indexPath.row];
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
    destinationSegue.selectedZone = [zoneArray objectAtIndex:selectedRow];
}

#pragma mark CallBack Protocole Zone

- (void)getZone:(id)zone {
    self.zoneNeeded = (Zone *)zone;
}

- (void)getAllZones:(NSMutableArray *)allZones{
    if (self.zoneStateSelector.selectedSegmentIndex == 0) {
        for (int i = 0; i < allZones.count; i++) {
            Zone * newZone = [allZones objectAtIndex:i];
            [zoneArray addObject:newZone];
        }
    } else if (self.zoneStateSelector.selectedSegmentIndex == 1) {
        for (int i = 0; i < allZones.count; i++) {
            Zone * newZone = [allZones objectAtIndex:i];
            
            if ([newZone.used  isEqual: @"1"]) {
                [zoneArray addObject:newZone];
            }
        }
    }else {
        for (int i = 0; i < allZones.count; i++) {
            Zone * newZone = [allZones objectAtIndex:i];
            
            if ([newZone.used  isEqual: @"0"]) {
                [zoneArray addObject:newZone];
            }
        }
    }
    
    [self.zonesTableView reloadData];
}

- (void) zoneCreated {
    
}

- (IBAction)clickZoneStateSelector:(id)sender {
    [zoneArray removeAllObjects];
    [Zone getAllZonesWithSender:self];
}
@end

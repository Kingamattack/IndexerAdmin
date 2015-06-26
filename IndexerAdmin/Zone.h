//
//  Zone.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Coordinates.h"
#import "AppDelegate.h"


@interface Zone : NSObject
@property NSNumber * zoneID;
@property NSString * zoneName;
@property NSString * zoneColor;
@property NSString * perimeter;
@property NSMutableArray * pointsData; //format json but sended as string to server
@property NSNumber * used;

- (void) createZone;
- (void) disableZone;
- (void) updateZone;
+ (void) getZone:(NSNumber*)zoneId sender:(id<ZoneManagement>)sender;
+ (void) getAllZonesWithSender:(id<ZoneManagement>)sender;

- (instancetype) init;

@end

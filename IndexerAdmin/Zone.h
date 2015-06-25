//
//  Zone.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

typedef enum : NSUInteger {
    RED, YELLOW, GREEN,
} Color;

@interface Zone : NSObject
@property NSNumber *zoneId;
@property NSString *zoneColor;
@property NSString * perimeter; //format json but sended as string to server
@property NSNumber *used;

@property Color _color;

- (void) createZone;
- (void) disableZone;
- (void) updateZone;
+ (void) getZone:(NSNumber*)zoneId sender:(id<ZoneManagement>)sender;

@end

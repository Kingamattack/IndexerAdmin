//
//  Zone.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RED, YELLOW, GREEN,
} Color;

@interface Zone : NSObject {
    int zoneID;
    Color zoneColor;
    NSMutableDictionary * perimeter;
    BOOL isEnable;
}

@property Color _color;

- (void) createZone;
- (void) updateZone;
- (void) disableZone;

@end

//
//  Zone.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "Zone.h"
#import "AFHTTPRequestOperationManager.h"

@implementation Zone

- (instancetype) init {
    self = [super init];
    if (self) {
        self.used = [NSNumber numberWithInt:1];        
        self.pointsData = [[NSMutableArray alloc] init];
}
    return self;
}

- (void) createZone:(id<ZoneManagement>)sender{
    // REQUETE WEB SERVICE ADD ZONE
    
    NSString *url = @"http://pierre-mar.net/Zone_indexer/";
    NSDictionary *parameters = @{@"createZone":@1, @"color":self.zoneColor, @"perimeter":self.perimeter, @"title":self.zoneName};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Zone *currentObject = self;
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *jsonZone = responseObject;
         currentObject.zoneID = [jsonZone objectForKey:@"id"];
         [sender zoneCreated];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

- (void) updateZone {
    NSString *url = @"http://pierre-mar.net/Zone_indexer/";
    NSDictionary *parameters = @{@"updateZone":@1, @"id":self.zoneID, @"color":self.zoneColor, @"perimeter":self.perimeter,  @"used":self.used, @"title":self.zoneName};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

- (void) disableZone {
    NSString *url = @"http://pierre-mar.net/Zone_indexer/";
    NSDictionary *parameters = @{@"disableZone":@1, @"id":self.zoneID};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

+ (void) getZone:(NSNumber*)zoneId sender:(id<ZoneManagement>)sender{
    NSString *url = @"http://pierre-mar.net/Zone_indexer/";
    NSDictionary *parameters = @{@"getZone":@1, @"id":zoneId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *jsonZone = responseObject;
         Zone *zone = [[Zone alloc] init];
         zone.zoneID = zoneId;
         zone.zoneColor = [jsonZone objectForKey:@"color"];
         zone.zoneName = [jsonZone objectForKey:@"title"];
         zone.used = [jsonZone objectForKey:@"used"];
         NSArray* perimeter = [jsonZone objectForKey:@"perimeter"];
         
         for(int i = 0; i < perimeter.count; i++){
             NSDictionary *coord = [perimeter objectAtIndex:i];
             Coordinates *coordinate = [[Coordinates alloc] init];
             coordinate.latitude = [coord objectForKey:@"lat"];
             coordinate.longitude = [coord objectForKey:@"long"];
             [zone.pointsData addObject:coordinate];
         }
         
         [sender getZone:zone];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

+ (void) getAllZonesWithSender:(id<ZoneManagement>)sender{
    NSString *url = @"http://pierre-mar.net/Zone_indexer/";
    NSDictionary *parameters = @{@"getAllZones":@1};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSMutableArray *allZones = [[NSMutableArray alloc] init];
         
         NSLog(@"JSON: %@", responseObject);
         NSArray *jsonZones = responseObject;
         
         for(int i = 0; i < jsonZones.count; i++){
             NSDictionary * jsonZone = [jsonZones objectAtIndex:i];
             Zone *zone = [[Zone alloc] init];
             zone.zoneID = [jsonZone objectForKey:@"id"];
             zone.zoneColor = [jsonZone objectForKey:@"color"];
             zone.zoneName = [jsonZone objectForKey:@"title"];
             zone.used = [jsonZone objectForKey:@"used"];
             NSArray* perimeter = [jsonZone objectForKey:@"perimeter"];
             
             for(int i = 0; i < perimeter.count; i++){
                 NSDictionary *coord = [perimeter objectAtIndex:i];
                 Coordinates *coordinate = [[Coordinates alloc] init];
                 coordinate.latitude = [coord objectForKey:@"lat"];
                 coordinate.longitude = [coord objectForKey:@"long"];
                 [zone.pointsData addObject:coordinate];
             }
             
             NSLog(@"PERIMETER: %@", zone.pointsData);
             [allZones addObject:zone];
         }
         
        [sender getAllZones:allZones];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

@end

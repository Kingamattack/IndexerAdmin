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

- (void) createZone {
    // REQUETE WEB SERVICE ADD ZONE
    
    NSString *url = @"http://pierre-mar.net/Zone_indexer/";
    NSDictionary *parameters = @{@"createZone":@1, @"color":self.zoneColor, @"perimeter":self.perimeter};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Zone *currentObject = self;
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *jsonZone = responseObject;
         currentObject.zoneId = [jsonZone objectForKey:@"id"];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

- (void) updateZone {
    NSString *url = @"http://pierre-mar.net/Zone_indexer/";
    NSDictionary *parameters = @{@"updateZone":@1, @"id":self.zoneId, @"color":self.zoneColor, @"perimeter":self.perimeter,  @"used":self.used};
    
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
    NSDictionary *parameters = @{@"disableZone":@1, @"id":self.zoneId};
    
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
         zone.zoneId = zoneId;
         zone.zoneColor = [jsonZone objectForKey:@"color"];
         zone.perimeter = [jsonZone objectForKey:@"perimeter"];
         [sender getZone:zone];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

@end

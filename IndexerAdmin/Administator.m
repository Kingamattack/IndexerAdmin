//
//  Administator.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "Administator.h"
#import "AFHTTPRequestOperationManager.h"

@implementation Administator 

- (void) sendZone:(Zone *)aZone{
    
    [aZone createZone:self];

}

@end

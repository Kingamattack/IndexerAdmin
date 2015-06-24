//
//  Administator.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "User.h"
#import "Zone.h"
#import <Foundation/Foundation.h>

@interface Administator : User

+ (void) sendZone:(Zone*) aZone;

@end

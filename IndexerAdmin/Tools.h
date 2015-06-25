//
//  Tools.h
//  IndexerAdmin
//
//  Created by MAR Pierre on 24/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+ (NSData*) getJsonDataWithUrlPath:(NSString*)urlPath;
+ (NSString*) getStringDataWithUrlPath:(NSString*)urlPath;
+ (BOOL) canConnectToWeb;

@end

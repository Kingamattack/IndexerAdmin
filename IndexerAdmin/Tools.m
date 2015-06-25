//
//  Tools.m
//  IndexerAdmin
//
//  Created by MAR Pierre on 24/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSData*) getJsonDataWithUrlPath:(NSString*)urlPath{
    NSURL* url = [NSURL URLWithString:urlPath];
    return [NSData dataWithContentsOfURL:url];
}

+ (NSString*) getStringDataWithUrlPath:(NSString*)urlPath{
    NSURL* url = [NSURL URLWithString:urlPath];
    return [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
}


+ (BOOL) canConnectToWeb{
    NSData* data = [Tools getJsonDataWithUrlPath:[NSString stringWithFormat:@"http://localhost:8888/studentGrades/webservice.php"]];
    
    if(data == nil){
        return NO;
    }
    else{
        return YES;
    }
}

@end

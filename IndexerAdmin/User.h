//
//  User.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    int userID;
    NSString * mail;
    NSString * password;
    
}

@property BOOL isAdmin;


@end

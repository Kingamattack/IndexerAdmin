//
//  User.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface User : NSObject

@property NSNumber * userId;
@property NSString * mail;
@property NSString * password;
@property NSNumber * isAdmin;
@property NSMutableArray * notes;

- (void) create;
- (BOOL) checkAuth :(NSString *) enteredPassword;
+ (void) getUserByMail:(NSString *)mail sender:(id<UserManagement>)sender;

@end

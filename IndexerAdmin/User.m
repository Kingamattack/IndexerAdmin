//
//  User.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "User.h"
#import "AFHTTPRequestOperationManager.h"

@implementation User

- (BOOL) checkAuth: (NSString*) enteredPassword {
    if([self.password isEqualToString:enteredPassword]){
        return true;
    }
    else{
        return false;
    }
}

- (void) create{
    
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"createUser":@1, @"mail":self.mail, @"pass":self.password, @"isAdmin":self.isAdmin};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    User *currentObject = self;
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *jsonUser = responseObject;
         currentObject.userId = [jsonUser objectForKey:@"id"];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
    
}

+ (void) getUserByMail: (NSString*)mail sender:(id<UserManagement>)sender{
    // REQUETE WEB SERVICE USER/ADMIN
    
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"getUserByMail":@1, @"mail":mail};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //get User from json
              NSDictionary * userDict = responseObject;
              User* user = [[User alloc] init];
              user.userId = [userDict objectForKey:@"id"];
              user.mail = mail;
              user.password = [userDict objectForKey:@"password"];
              user.isAdmin = [userDict objectForKey:@"isAdmin"];
              
              [sender getUser:user];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"ErrorPost: %@", error);
          }];
}

@end

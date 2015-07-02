//
//  LoginViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "User.h"
#import <UIKit/UIKit.h>
#import "Administator.h"
#import "AFNetworking.h"
#import "HomeViewController.h"
#import "AdministrationViewController.h"


@interface LoginViewController : UIViewController<UserManagement>

@property User * user;
@property IBOutlet UITextField * mailTF;
@property IBOutlet UITextField * passwordTF;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView * loader;

/**
 *
 *  Launch the connection to the web service to check
 *
 */
- (IBAction)clickConnexionBTN:(id)sender;

/**
 *
 *  Manage the connection and send the user to the good View
 *
 */
- (void)manageConnection;

@end

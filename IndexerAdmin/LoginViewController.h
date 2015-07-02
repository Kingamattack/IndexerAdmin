//
//  LoginViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Client.h"
#import "Administator.h"

@interface LoginViewController : UIViewController<UserManagement>
    
@property IBOutlet UITextField *mailTF;
@property IBOutlet UITextField *passwordTF;
@property IBOutlet UIButton *connexionBTN;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;

@property User *user;

- (IBAction)clickConnexionBTN:(id)sender;
- (void )manageConnection;

@end

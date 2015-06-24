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

@interface LoginViewController : UIViewController {
    
    IBOutlet UITextField *mailTF;
    IBOutlet UITextField *passwordTF;
    IBOutlet UIButton *connexionBTN;
}

- (IBAction)clickConnexionBTN:(id)sender;

@end

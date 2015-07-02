//
//  LoginViewController.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AdministrationViewController.h"
#import "AFNetworking.h"
#import "Client.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.user = [[User alloc] init];
    [self.loader setHidden:YES];
    [self.loader setHidesWhenStopped:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickConnexionBTN:(id)sender {

    NSString * mail = self.mailTF.text;
    [User getUserByMail:mail sender:self];
    [self.loader startAnimating];
}

/* ----------------- CALLBACK PROTOCOL ------------------ */

- (void) getUser:(id)user{
    self.user = (User *) user;
    [self manageConnection];
}

/* ---------------- END CALLBACK PROTOCOL --------------- */

- (void) manageConnection{
    
    //check authentication
    NSString *enteredPassword = self.passwordTF.text;
    
    if(![self.user checkAuth:enteredPassword]){
        NSLog(@"Incorrect password");
        return;
    }
    
    NSLog(@"correct password");
    //choose action depending to usertype
    if([self.user.isAdmin isEqualToNumber: @1]){
        [self performSegueWithIdentifier:@"goToHome" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"goToUser" sender:self];
    }
    
    [self.loader stopAnimating];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToHome"]) {
        User * newUser = [[User alloc] init];
        HomeViewController* vc = segue.destinationViewController;
        vc.user = newUser;
    }
    else if([segue.identifier isEqualToString:@"goToUser"]){
        
    }
}

@end

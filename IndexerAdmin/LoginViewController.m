//
//  LoginViewController.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 23/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "LoginViewController.h"

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
    
    // Check if the user with this mail exist
    [User getUserByMail:mail sender:self];
    [self.loader startAnimating];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToHome"]) {
        User * newUser = [[User alloc] init];
        HomeViewController * vc = segue.destinationViewController;
        vc.user = newUser;
    } 
}

#pragma mark CallBack Protocole

- (void) getUser:(id)user {
    self.user = (User *) user;
    [self manageConnection];
}

- (void) manageConnection {
    
    // Check if the password match with the mail
    NSString * enteredPassword = self.passwordTF.text;
    
    if(![self.user checkAuth:enteredPassword]){
        NSLog(@"Incorrect password");
        return;
    }
    
    NSLog(@"correct password");
    // Display the administrator or the user View
    if([self.user.isAdmin isEqualToNumber: @1]) {
        [self performSegueWithIdentifier:@"goToHome" sender:self];
    } else {
        [self performSegueWithIdentifier:@"goToUser" sender:self];
    }
    
    [self.loader stopAnimating];
}

@end

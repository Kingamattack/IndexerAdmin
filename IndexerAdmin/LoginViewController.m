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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)clickConnexionBTN:(id)sender {
    // REQUETE WEB SERVICE USER/ADMIN
    
    User * newUser = [[User alloc] init];
    newUser.isAdmin = YES;
    
    if (newUser.isAdmin == YES) {
        Administator * newAdministrator = [[Administator alloc] init];
        [self performSegueWithIdentifier:@"goToHome" sender:self];
    }else {
        Client * newClient = [[Client alloc] init];
        [self performSegueWithIdentifier:@"goToUser" sender:self];
    }
}

//- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    if ([mailTF.text isEqualToString:@"MAIL"] && [passwordTF.text isEqualToString:@"PASS"]) {
//        return YES;
//    }else
//        return NO;
//}

@end

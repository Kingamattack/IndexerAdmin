//
//  ViewController.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "User.h"
#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property User * user;

- (void)setUser:(User *) user;


@end


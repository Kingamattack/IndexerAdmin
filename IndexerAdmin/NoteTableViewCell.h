//
//  NoteTableViewCell.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 29/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *noteZoneName;
@property (strong, nonatomic) IBOutlet UILabel *noteZoneContent;
@property (strong, nonatomic) IBOutlet UIView *separatorView;

@end

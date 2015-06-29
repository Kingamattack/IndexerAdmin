//
//  AppDelegate.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end
@protocol ZoneManagement <NSObject>

@required

- (void) getZone:(id)zone;
- (void) getAllZones:(NSMutableArray *) allZones;
- (void) zoneCreated;

@end
@protocol NoteManagement <NSObject>

@required

- (void) getNote:(id)note;
- (void) getNoteList:(NSMutableArray*)notes;
- (void) didDownloadNoteListFromZone:(NSMutableArray *)allNotes;

@end
@protocol UserManagement <NSObject>

@required

- (void) getUser:(id)user;

@end
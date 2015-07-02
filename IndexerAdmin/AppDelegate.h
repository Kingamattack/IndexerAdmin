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

/**
 *
 * Protocol used for all class which need tu use Zone methods
 *
 */
@protocol ZoneManagement <NSObject>

@required

- (void) zoneWasGetting:(id)zone;
- (void) getAllZones:(NSMutableArray *) allZones;
- (void) zoneCreated;
- (void) zoneWasDisable:(BOOL) statut;
- (void) zoneWasEnable:(BOOL) statut;

@end

/**
 *
 * Protocol used for all class which need tu use Zone methods
 *
 */
@protocol NoteManagement <NSObject>

@required

- (void) getNote:(id)note;
- (void) noteListWasGetting:(NSMutableArray*)notes;
- (void) didDownloadNoteListFromZone:(NSMutableArray *)allNotes;

@end
@protocol UserManagement <NSObject>

@required

- (void) getUser:(id)user;

@end
//
//  Note.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Note : NSObject

@property NSNumber *noteId;
@property NSNumber *ownerId;
@property NSNumber *zoneId;
@property NSString *content;

- (void) createNote;
- (void) updateNote;
- (void) deleteNote;

+ (void) getNote:(NSNumber*)noteId sender:(id<NoteManagement>)sender;
+ (void) getAllNotesFromUser:(NSNumber*)userId sender:(id<NoteManagement>)sender;
+ (void) getAllNotesFromUser:(NSNumber*)userId AndZone:(NSNumber*)zoneId sender:(id<NoteManagement>)sender;


@end

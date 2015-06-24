//
//  Note.h
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject {
    int noteID;
    int ownerID;
    int zoneID;
    NSString * content;
}

- (void) createNote;
- (void) updateNote;
- (void) deleteNote;

@end

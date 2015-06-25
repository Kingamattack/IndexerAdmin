//
//  Note.m
//  IndexerAdmin
//
//  Created by Jordy Kingama on 22/06/2015.
//  Copyright (c) 2015 Jordy Kingama. All rights reserved.
//

#import "Note.h"
#import "AFHTTPRequestOperationManager.h"

@implementation Note

- (void) createNote {
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"createNote":@1, @"text":self.content, @"ownerId":self.ownerId, @"zoneId":self.zoneId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    Note *currentObject = self;
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *jsonNote = responseObject;
         currentObject.noteId = [jsonNote objectForKey:@"id"];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

- (void) updateNote {
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"updateNote":@1, @"text":self.content};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

- (void) deleteNote {
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"deleteNote":@1, @"id":self.noteId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

+ (void) getNote:(NSNumber*)noteId sender:(id<NoteManagement>)sender{
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"getZone":@1, @"id":noteId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *jsonZone = responseObject;
         Note *note = [[Note alloc] init];
         note.noteId = noteId;
         note.content = [jsonZone objectForKey:@"text"];
         note.ownerId = [jsonZone objectForKey:@"ownerId"];
         note.zoneId = [jsonZone objectForKey:@"zoneId"];
         [sender getNote:note];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}
+ (void) getAllNotesFromUser:(NSNumber*)userId sender:(id<NoteManagement>)sender{
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"getAllNotesFromUser":@1, @"idUser":userId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSMutableArray *notes = [[NSMutableArray alloc] init];
         NSMutableArray *jsonNotes = responseObject;
         for(int i = 0; i < jsonNotes.count; i++){
             NSDictionary *jsonNote = jsonNotes[i];
             Note *note = [[Note alloc] init];
             note.noteId = [jsonNote objectForKey:@"id"];
             note.content = [jsonNote objectForKey:@"text"];
             note.ownerId = [jsonNote objectForKey:@"ownerId"];
             note.zoneId = [jsonNote objectForKey:@"zoneId"];
             [notes addObject:note];
         }
         [sender getNoteList:notes];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}
+ (void) getAllNotesFromUser:(NSNumber*)userId AndZone:(NSNumber*)zoneId sender:(id<NoteManagement>)sender{
    NSString *url = @"http://localhost:8888/Zone_indexer/";
    NSDictionary *parameters = @{@"getAllNotesFromUser":@1, @"idUser":userId, @"idZone":zoneId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         NSMutableArray *notes = [[NSMutableArray alloc] init];
         NSMutableArray *jsonNotes = responseObject;
         for(int i = 0; i < jsonNotes.count; i++){
             NSDictionary *jsonNote = jsonNotes[i];
             Note *note = [[Note alloc] init];
             note.noteId = [jsonNote objectForKey:@"id"];
             note.content = [jsonNote objectForKey:@"text"];
             note.ownerId = [jsonNote objectForKey:@"ownerId"];
             note.zoneId = [jsonNote objectForKey:@"zoneId"];
             [notes addObject:note];
         }
         [sender getNoteList:notes];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"ErrorPost: %@", error);
     }];
}

@end

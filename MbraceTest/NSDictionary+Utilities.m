//
//  NSDictionary+Utilities.m
//  MbraceTest
//
//  Created by Nissim Pardo on 7/8/14.
//  Copyright (c) 2014 androdogs. All rights reserved.
//

#import "NSDictionary+Utilities.h"
#import "NPDataBaseManager.h"
#import "Notes.h"


@implementation NSDictionary (Utilities)
- (void)updateNote {
    Notes *note = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Notes"];
    request.predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", self[Id]];
    NSError *error = nil;
    NSArray *matches = [DBMgr.managedContext executeFetchRequest:request
                                                           error:&error];
    if (error) {
        NSLog(@"Error while fetching Core data: %@", error.description);
    } else if (!matches.count) {
        note = [NSEntityDescription insertNewObjectForEntityForName:@"Notes"
                                             inManagedObjectContext:DBMgr.managedContext];
        note.uniqueId = self[Id];
        note.text = [self[Text] isKindOfClass:[NSNull class]] ? @"" : self[Text];
        [self detectLink:note];
        
    } else if (matches.count == 1) {
        note = matches.lastObject;
        note.text = self[Text];
        [self detectLink:note];
    } else if (matches.count > 1) {
        NSLog(@"Error while fetching too much entities for uniqueId");
    }
}

- (void)detectLink:(Notes *)note {
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:&error];
    NSArray *matches = [detector matchesInString:note.text
                                         options:0
                                           range:NSMakeRange(0, [note.text length])];
    for (NSTextCheckingResult *match in matches) {
        //NSRange matchRange = [match range];
        if ([match resultType] == NSTextCheckingTypeLink) {
            note.link = [match URL].absoluteString;
        }
    }
}
@end

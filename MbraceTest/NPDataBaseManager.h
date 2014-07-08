//
//  NPDataBaseManager.h
//  MbraceTest
//
//  Created by Nissim Pardo on 7/8/14.
//  Copyright (c) 2014 androdogs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


#define DBMgr [NPDataBaseManager shared]

@interface NPDataBaseManager : NSObject {
    NSArray *notes;
}
+ (NPDataBaseManager *)shared;

- (void)contextWithCompletion:(void(^)())completion;
- (void)updateDataBaseWithCompletion:(void(^)())completion;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedContext;
@property (nonatomic, strong, readonly) NSArray *allNotes;
@end

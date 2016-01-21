//
//  CoreDataStack.h
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *contextMain;
@property (readonly, strong, nonatomic) NSManagedObjectContext *contextRead;
@property (readonly, strong, nonatomic) NSManagedObjectContext *contextWork;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext:(NSManagedObjectContext *)context;
- (NSURL *)applicationDocumentsDirectory;

@end

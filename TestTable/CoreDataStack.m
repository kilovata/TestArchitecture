//
//  CoreDataStack.m
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import "CoreDataStack.h"

@implementation CoreDataStack

@synthesize contextMain = _contextMain;
@synthesize contextRead = _contextRead;
@synthesize contextWork = _contextWork;

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory
{
	// The directory the application uses to store the Core Data store file. This code uses a directory named "Tinkoff.TestTable" in the application's documents directory.
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
	// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestTable" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	// The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	// Create the coordinator and store
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TestTable.sqlite"];
	NSError *error = nil;
	NSString *failureReason = @"There was an error creating or loading the application's saved data.";
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		// Report any error we got.
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
		dict[NSLocalizedFailureReasonErrorKey] = failureReason;
		dict[NSUnderlyingErrorKey] = error;
		error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
		// Replace this with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}

- (void)saveContext:(NSManagedObjectContext *)context
{
	if (context.hasChanges)
	{
		__block NSManagedObjectContext *contextToSave = context;
		
		while (contextToSave) {
			[contextToSave performBlockAndWait:^{
				NSError *error;
				[contextToSave save:&error];
				if (error)
				{
					NSLog(@"Context saving failure: %@", [error localizedDescription]);
				}
				
				if (contextToSave.parentContext)
					contextToSave = contextToSave.parentContext;
				else
					contextToSave = nil;
			}];
		}
	}
}

#pragma mark - Contexts
- (NSManagedObjectContext *)contextMain
{
	static NSManagedObjectContext *ctx;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
		[ctx setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
		[ctx setMergePolicy:[[NSMergePolicy alloc] initWithMergeType:NSOverwriteMergePolicyType]];
		[ctx setUndoManager:nil];
	});
	
	return ctx;
}

- (NSManagedObjectContext *)contextRead
{
	static NSManagedObjectContext *ctx;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSAssert([NSThread isMainThread], @"Expect this method to be performed on main thread");
		
		ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[ctx setParentContext:[self contextMain]];
	});
	
	return ctx;
}

- (NSManagedObjectContext *)contextWork
{
	NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	[ctx setParentContext:[self contextRead]];
	
	return ctx;
}

@end

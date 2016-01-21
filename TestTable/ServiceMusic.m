//
//  ServiceMusic.m
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import "ServiceMusic.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "Album.h"

@interface ServiceMusic()

@property (nonatomic, strong) CoreDataStack *coreDataStack;

@end

@implementation ServiceMusic

- (CoreDataStack *)coreDataStack
{
	if (!_coreDataStack)
	{
		_coreDataStack = [CoreDataStack new];
	}
	return _coreDataStack;
}

- (void)addAlbum
{
	NSManagedObjectContext *context = self.coreDataStack.contextWork;
	
	[context performBlock:^{
		
		Album *album = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Album class]) inManagedObjectContext:context];
		album.songTitle = [NSString stringWithFormat:@"Song %lu", (unsigned long)[self countAlbums]];
		album.date = [NSDate date];
		album.albumID = @([self countAlbums]+1);
		[self.coreDataStack saveContext:context];
	}];
}

- (void)removeAlbumWithID:(NSNumber *)albumID
{
	NSManagedObjectContext *context = self.coreDataStack.contextWork;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Album class])];
	request.predicate = [NSPredicate predicateWithFormat:@"albumID == %@", albumID];
	NSError *error = nil;
	NSArray *array = [context executeFetchRequest:request error:&error];
	if (array.count > 0)
	{
		Album *album = [array lastObject];
		[context performBlock:^{
			
			[context deleteObject:album];
			[self.coreDataStack saveContext:context];
		}];
	}
}

- (NSUInteger)countAlbums
{
	NSManagedObjectContext *context = self.coreDataStack.contextWork;
	
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Album class])];
	NSError *error = nil;
	NSArray *array = [context executeFetchRequest:request error:&error];
	
	return array.count;
}

@end

//
//  DataSourceMusic.m
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import "DataSourceMusic.h"
#import "Album+CellTest.h"
#import "CoreDataStack.h"

static NSString *kCellTestReuseIdentifier = @"CellTest";

@interface DataSourceMusic()

@property (nonatomic, strong) CoreDataStack *coreDataStack;

@end

@implementation DataSourceMusic

- (ServiceMusic *)serviceMusic
{
	if (!_serviceMusic)
	{
		_serviceMusic = [ServiceMusic new];
	}
	return _serviceMusic;
}

- (CoreDataStack *)coreDataStack
{
	if (!_coreDataStack)
	{
		_coreDataStack = [CoreDataStack new];
	}
	return _coreDataStack;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger numberOfSections = [[self.fetchedResultsController sections] count];
	return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger numberOfRows = [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
	return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CellTest *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellTest class])];
	
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		Album *album = [self.fetchedResultsController objectAtIndexPath:indexPath];
		[self.serviceMusic removeAlbumWithID:album.albumID];
	}
}

#pragma mark - DataSourceInterface

- (NSFetchedResultsController *)fetchedResultsController
{
	if (!_fetchedResultsController)
	{
		NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([Album class])];
		NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
		request.sortDescriptors = @[sort];
		_fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.coreDataStack.contextRead sectionNameKeyPath:nil cacheName:nil];
		
		NSError *error = nil;
		[_fetchedResultsController performFetch:&error];
		
		if (error)
		{
			NSLog(@"fatal error = %@", error);
			return nil;
		}
	}
	
	return _fetchedResultsController;
}

- (void)prepareTableView:(UITableView *)tableView
{
	[tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellTest class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellTestReuseIdentifier];
	tableView.rowHeight = 60.f;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	Album *album = [self.fetchedResultsController objectAtIndexPath:indexPath];
	[album configureCell:(CellTest *)cell];
}

@end

//
//  MusicViewController.m
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()<NSFetchedResultsControllerDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) DataSourceMusic *dataSource;

@end

@implementation MusicViewController

- (instancetype)initWithDataSource:(DataSourceMusic *)dataSource
{
	if (self = [super init])
	{
		_dataSource = dataSource;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddAlbum)];
	[self.dataSource prepareTableView:self.table];
	self.dataSource.fetchedResultsController.delegate = self;
	
	self.table.dataSource = self.dataSource;
	self.table.delegate = self;
}

- (void)actionAddAlbum
{
	[self.dataSource.serviceMusic addAlbum];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	[self.table beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
 
	UITableView *tableView = self.table;
 
	switch(type) {
			
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self.dataSource configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray
											   arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:[NSArray
											   arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
 
	switch (type)
	{
		case NSFetchedResultsChangeInsert:
			[self.table insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.table deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
			case NSFetchedResultsChangeMove:
			break;
			
			case NSFetchedResultsChangeUpdate:
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[self.table endUpdates];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end

//
//  DataSourceInterface.h
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSourceInterface <UITableViewDataSource>

@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;

- (void)prepareTableView:(UITableView *)tableView;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end

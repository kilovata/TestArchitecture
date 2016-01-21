//
//  DataSourceMusic.h
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

#import "DataSourceInterface.h"
#import "ServiceMusic.h"

@interface DataSourceMusic : NSObject<DataSourceInterface>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) ServiceMusic *serviceMusic;

@end

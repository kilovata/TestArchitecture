//
//  ServiceMusic.h
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceMusic : NSObject

- (void)addAlbum;
- (void)removeAlbumWithID:(NSNumber *)albumID;
- (NSUInteger)countAlbums;

@end

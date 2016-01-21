//
//  Album+CellTest.m
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import "Album+CellTest.h"

@implementation Album (CellTest)

- (void)configureCell:(CellTest *)cell
{
	cell.imgViewPicture.backgroundColor = [UIColor yellowColor];
	cell.labelTitle.text = self.songTitle;
}

@end

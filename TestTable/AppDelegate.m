//
//  AppDelegate.m
//  TestTable
//
//  Created by Полищук Светлана on 21/01/16.
//  Copyright © 2016 Polishchuk Svetlana. All rights reserved.
//

#import "AppDelegate.h"
#import "MusicViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	MusicViewController *musicVC = [[MusicViewController alloc] initWithDataSource:[DataSourceMusic new]];
	UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController:musicVC];
	
	self.window.rootViewController = navCont;
	
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end

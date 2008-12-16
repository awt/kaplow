//
//  Comic_ReaderAppDelegate.m
//  Comic Reader
//
//  Created by Adam Thorsen on 11/8/08.
//  Copyright Owyhee Software, LLC 2008. All rights reserved.
//

#import "Comic_ReaderAppDelegate.h"
#import "RootViewController.h"


@implementation Comic_ReaderAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end

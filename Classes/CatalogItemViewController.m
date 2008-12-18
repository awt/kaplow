//
//  CatalogItemViewController.m
//  Comic Reader
//
//  Created by Adam Thorsen on 12/17/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import "CatalogItemViewController.h"


@implementation CatalogItemViewController


//The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withBookName:(NSString *)theBookName {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //Custom initialization
        bookName = bookName;
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end

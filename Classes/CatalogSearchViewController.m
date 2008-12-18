//
//  CatalogSearchViewController.m
//  Comic Reader
//
//  Created by Adam Thorsen on 12/17/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import "CatalogSearchViewController.h"
#import "CatalogItemViewController.h"

@implementation CatalogSearchViewController

- (void)dealloc {
    [myTableView release];
    [mySearchBar release];
    
    [filteredListContent release];
    [savedContent release];
    
    [books release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    books = [[NSArray arrayWithObjects:@"shade", @"y-men", @"the purple flashlight", nil] retain];

    // create our filtered list that will be the data source of our table, start its content from the master "books"
    filteredListContent = [[NSMutableArray alloc] initWithCapacity: [books count]];
    [filteredListContent addObjectsFromArray: books];
    
    // this stored the current list in case the user cancels the filtering
    savedContent = [[NSMutableArray alloc] initWithCapacity: [books count]]; 
            
    // don't get in the way of user typing
    mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    mySearchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    mySearchBar.showsCancelButton = NO;

    self.title = NSLocalizedString(@"Online Catalog", @"Master view navigation title");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [filteredListContent count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil)
    {
      cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cellID"] autorelease];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.text = [filteredListContent objectAtIndex:indexPath.row];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CatalogItemViewController *catalogItemViewController = [[CatalogItemViewController alloc] initWithNibName:@"CatalogItemViewController" 
                                                                                              bundle:nil 
                                                                                              withBookName:[filteredListContent objectAtIndex:indexPath.row]];    
    [[self navigationController] pushViewController:catalogItemViewController animated:YES];
    [catalogItemViewController release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	// only show the status bar's cancel button while in edit mode
	mySearchBar.showsCancelButton = YES;
	
	// flush and save the current list content in case the user cancels the search later
	[savedContent removeAllObjects];
	[savedContent addObjectsFromArray: filteredListContent];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	mySearchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	[filteredListContent removeAllObjects];	// clear the filtered array first
	
	// search the table content for cell titles that match "searchText"
	// if found add to the mutable array and force the table to reload
	//
	NSString *cellTitle;
	for (cellTitle in books)
	{
		NSComparisonResult result = [cellTitle compare:searchText options:NSCaseInsensitiveSearch
										range:NSMakeRange(0, [searchText length])];
		if (result == NSOrderedSame)
		{
			[filteredListContent addObject:cellTitle];
		}
	}
	
	[myTableView reloadData];
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	// if a valid search was entered but the user wanted to cancel, bring back the saved list content
	if (searchBar.text.length > 0)
	{
		[filteredListContent removeAllObjects];
		[filteredListContent addObjectsFromArray: savedContent];
	}
	
	[myTableView reloadData];
	
	[searchBar resignFirstResponder];
	searchBar.text = @"";
}

// called when Search (in our case "Done") button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}



@end


//
//  CatalogSearchViewController.h
//  Comic Reader
//
//  Created by Adam Thorsen on 12/17/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CatalogSearchViewController : UITableViewController {
  NSArray                 *books;
	IBOutlet UITableView		*myTableView;
	IBOutlet UISearchBar		*mySearchBar;
	
	NSArray						    *listContent;			    // the master content
	NSMutableArray				*filteredListContent;	// the filtered content as a result of the search
	NSMutableArray				*savedContent;			  // the saved content in case the user cancels a search
}

@end

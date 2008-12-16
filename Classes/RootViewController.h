//
//  RootViewController.h
//  Comic Reader
//
//  Created by Adam Thorsen on 11/8/08.
//  Copyright Owyhee Software, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
  NSArray *options;
  NSMutableData *receivedData;
  NSURLConnection *connection;
  UIViewController *librarySearchViewController;
  UIViewController *catalogSearchViewController;
}

int gzopen_frontend(char *pathname, int oflags, int mode);

@end

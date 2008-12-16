//
//  ComicViewController.h
//  Comic Reader
//
//  Created by Adam Thorsen on 11/9/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ComicViewController : UIViewController {
  NSString *bookName;
}
  
- (ComicViewController *)initWithBookName:theBookName;

@end

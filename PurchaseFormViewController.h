//
//  PurchaseFormViewController.h
//  Comic Reader
//
//  Created by Adam Thorsen on 12/17/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PurchaseFormViewController : UIViewController {
  NSString *bookName;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withBookName:(NSString *)theBookName;

@end

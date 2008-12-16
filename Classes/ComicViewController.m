//
//  ComicViewController.m
//  Comic Reader
//
//  Created by Adam Thorsen on 11/9/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import "ComicViewController.h"
#import "ComicView.h"
#import "ComicViewController.h"

@implementation ComicViewController

- (ComicViewController *)initWithBookName:(NSString *)theBookName {
  if (self = [super init]) {
    bookName = [theBookName retain];
  }
  return self;
}

- (void)loadView {
  CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
  self.view = [[ComicView alloc] initWithFrame:applicationFrame bookName:bookName];
}

- (void)dealloc {
    [bookName release];
    [super dealloc];
}
@end

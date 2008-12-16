//
//  ComicView.h
//  Comic Reader
//
//  Created by Adam Thorsen on 11/9/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ComicView : UIImageView {

  CGPoint startTouchPosition; 
  UIImageView *imageView;
  NSMutableArray *frames;
  NSArray *pages;
  int currentPageIndex;
  int currentFrameIndex;
  NSEnumerator *frameEnumerator;
  NSString *bookName;
}
- (id)initWithFrame:(CGRect)frame bookName:(NSString *)bookName;
- (void)advanceFrame;
- (void)goBack;
- (void)setComicFrame:(int)frameIndex;
- (void)setPage:(int)pageIndex withFrameIndex:(int)frameIndex;

@end

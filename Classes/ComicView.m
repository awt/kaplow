//
//  ComicView.m
//  Comic Reader
//
//  Created by Adam Thorsen on 11/9/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import "ComicView.h"
#import "ComicFrame.h"
#import "YAML.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

#define HORIZ_SWIPE_DRAG_MIN  10
#define VERT_SWIPE_DRAG_MAX    6

@implementation ComicView

- (id)initWithFrame:(CGRect)frame bookName:(NSString *)theBookName {
  if (self = [super initWithFrame:frame]) {
    currentPageIndex = 0;
    currentFrameIndex = 0;
    imageView = nil;
    bookName = [theBookName retain];
    NSString *documentsDirectory = [NSString documentsDirectory];
    NSString *bookPath = [[NSString pathWithComponents:[NSArray arrayWithObjects:documentsDirectory,theBookName,@"pages", nil]] stringByAppendingPathExtension:@"yml"];
    NSString *bookFileContent = [NSString stringWithContentsOfFile:bookPath encoding:NSUTF8StringEncoding error:NULL]; 

    id data = yaml_parse(bookFileContent);
    pages = [[data objectForKey:@"pages"] retain];

    self.userInteractionEnabled = YES;
    [self setPage:0 withFrameIndex:0];

  }
  return self;
} 


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    startTouchPosition = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint finalTouchPosition = [touch locationInView:self];
  // If the swipe tracks correctly.
  if (fabsf(startTouchPosition.x - finalTouchPosition.x) >= HORIZ_SWIPE_DRAG_MIN &&
      fabsf(startTouchPosition.y - finalTouchPosition.y) <= VERT_SWIPE_DRAG_MAX)
  {
      // It appears to be a swipe.
      if (startTouchPosition.x < finalTouchPosition.x)
          [self goBack];
      else
          [self advanceFrame];
  }
  else
  {
      // Process a non-swipe event.
  }

}

- (void)setPage:(int)pageIndex withFrameIndex:(int)frameIndex {
    
    NSDictionary *page = [pages objectAtIndex:pageIndex];
    NSArray *framesFromYAML = [page objectForKey:@"frames"];
    if (nil == imageView) {
      imageView = [[UIImageView alloc] initWithImage:[self imageForName:[page objectForKey:@"image"]]];
      [self addSubview:imageView];
    }
    else {
      imageView.image = [self imageForName:[page objectForKey:@"image"]];
    }

    frames = [[ComicFrame framesWithArray:framesFromYAML withImageView:imageView] retain];

    if (frameIndex < 0) {
      [self setComicFrame:([frames count] -1)];
    }
    else {
      [self setComicFrame:frameIndex];
    }
}

- (void)imageForName:(NSString *)imageName {
    NSString *documentsDirectory = [NSString documentsDirectory];
    NSString *imagePath = [NSString pathWithComponents:[NSArray arrayWithObjects:documentsDirectory,bookName,imageName,nil]];
    return [UIImage imageWithContentsOfFile:imagePath]; 
}

- (void)setComicFrame:(int)frameIndex {
  currentFrameIndex = frameIndex;
  ComicFrame *frame = [frames objectAtIndex:currentFrameIndex];

  [UIView beginAnimations:@"position" context:nil];
  NSLog(@"delay: %f", frame.delay);
  [UIView setAnimationDuration:frame.delay];
  CGRect newBounds = self.bounds;
  newBounds.origin = frame.origin;
  self.bounds = newBounds;
  imageView.frame = frame.frame;
  [UIView commitAnimations];
}

- (void)advancePage {
  if(currentPageIndex < ([pages count] - 1)) {
    currentPageIndex = currentPageIndex + 1;
    [self setPage:currentPageIndex withFrameIndex:0];
    NSLog(@"Advance page!");
  }
  else {
    NSLog(@"No more pages!");
  }
}

- (void)regressPage {
  if(currentPageIndex > 0) {
    currentPageIndex = currentPageIndex - 1;
    [self setPage:currentPageIndex withFrameIndex:-1];
    NSLog(@"Regress page!");
  }
  else {
    NSLog(@"First page!");
  }
}

- (void)advanceFrame {

  if(currentFrameIndex < ([frames count] - 1)) {
    currentFrameIndex = currentFrameIndex + 1;
    [self setComicFrame:currentFrameIndex];
    NSLog(@"Advance frame!");
  }
  else {
    [self advancePage];
  }

}

- (void)goBack {

  if(currentFrameIndex > 0) {
    currentFrameIndex = currentFrameIndex - 1;
    [self setComicFrame:currentFrameIndex];
    NSLog(@"Go Back!");
  }
  else {
    [self regressPage];
  }
}




- (void)dealloc {
    [frames release];
    [bookName release];
    [super dealloc];
}


@end

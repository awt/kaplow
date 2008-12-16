//
//  ComicFrame.m
//  Comic Reader
//
//  Created by Adam Thorsen on 11/22/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import "ComicFrame.h"
#import <QuartzCore/QuartzCore.h>

@implementation ComicFrame

@synthesize origin;
@synthesize frame;
@synthesize delay;

- (id)initWithImageView:(UIImageView *)imageView topLeft:(CGPoint)topLeft bottomRight:(CGPoint)bottomRight delay:(float)theDelay {
  if (self = [super init]) {
    frame = imageView.frame;
    origin = topLeft;
    delay = theDelay;

    CGFloat frameWidth = bottomRight.x - topLeft.x;
    CGFloat frameHeight = bottomRight.y - topLeft.y;
    
    CGSize kMaxImageViewSize = {.width = 320 * 612 / frameWidth, .height = 416 * 800 / frameHeight};
    CGSize imageSize = imageView.image.size;
    CGFloat aspectRatio = imageSize.width / imageSize.height;
    if (kMaxImageViewSize.width / aspectRatio <= kMaxImageViewSize.height) {
        frame.size.width = kMaxImageViewSize.width;
        frame.size.height = frame.size.width / aspectRatio;
    } else {
        frame.size.height = kMaxImageViewSize.height;
        frame.size.width = frame.size.height * aspectRatio;
    }

  }
  return self;
}

+ (NSArray *)framesWithArray:(NSArray *)framesFromYAML withImageView:(UIImageView *)imageView
{
  NSMutableArray *frames = [[NSMutableArray alloc] init];
  for (NSDictionary *aFrame in framesFromYAML)
  {
    CGPoint p1 = CGPointMake([[aFrame objectForKey:@"x1"] floatValue], [[aFrame objectForKey:@"y1"] floatValue]);
    CGPoint p2 = CGPointMake([[aFrame objectForKey:@"x2"] floatValue], [[aFrame objectForKey:@"y2"] floatValue]);
    [frames addObject:[[ComicFrame alloc] initWithImageView:imageView topLeft:p1 bottomRight:p2 delay:[[aFrame objectForKey:@"delay"] floatValue]]];
  }
  return [frames autorelease];
}

@end

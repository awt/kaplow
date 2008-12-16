//
//  ComicFrame.h
//  Comic Reader
//
//  Created by Adam Thorsen on 11/22/08.
//  Copyright 2008 Owyhee Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ComicFrame : NSObject {
  CGPoint origin;
  CGRect frame;
  float delay;
}

@property(readonly) CGPoint origin;
@property(readonly) CGRect frame;
@property(readonly) float delay;

- (id)initWithImageView:(UIImageView *)imageView topLeft:(CGPoint)topLeft bottomRight:(CGPoint)bottomRight delay:(float)theDelay;
+ (NSArray *)framesWithArray:(NSArray *)framesFromYAML withImageView:(UIImageView *)imageView;
@end

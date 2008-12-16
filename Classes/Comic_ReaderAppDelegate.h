//
//  Comic_ReaderAppDelegate.h
//  Comic Reader
//
//  Created by Adam Thorsen on 11/8/08.
//  Copyright Owyhee Software, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Comic_ReaderAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end


//
//  iEstimatorAppDelegate.h
//  iEstimator
//
//  Created by John Wooten on 12/31/08.
//  Copyright ShouldersCorp. 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iEstimatorAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;

    
}

- (void)applicationDidFinishLaunching:(UIApplication *)application;

//- (void) test;


@property (nonatomic, retain) IBOutlet UIWindow *window;

@end


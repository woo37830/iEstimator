//
//  iEstimatorAppDelegate.m
//  iEstimator
//
//  Created by John Wooten on 12/31/08.
//  Edited on 03/31/2009
//  Copyright ShouldersCorp. 2008. All rights reserved.
//

#import "iEstimatorAppDelegate.h"
#import "EstimationModel.h"
#import "Statistics.h"
#import "Team.h"
#import "Resource.h"
#import "Project.h"

@implementation iEstimatorAppDelegate

@synthesize window;

- (void) test	{
    /*
	// Override point for customization after application launch
	EstimationModel *model = [[EstimationModel alloc] init];
	int fp = [model functionPoints];
	printf("function Points = %i\n", fp);
	float duration = [model duration];
	printf("duration in months = %3.1f\n", duration);
	printf("effort in person months = %3.1f\n", [model effort]);
	printf("team Size recommended = %d\n", [model teamSize]);
    printf("Total Project Cost = %9.0f\n", [model totalCost]);
	//
	printf("Test getter and setter \n");
	[model setExtInputs: 5];
	printf("Value set was %i\n", [model extInputs]);
	printf("Effect was %3.1f\n", [model duration]);
	printf("Test setting functionPoints\n");
	[model setFunctionPoints: 1450];
	printf("After resetting to 1450 duration is: %3.1f\n", [model duration]);
	EstimationModel *new = [[EstimationModel alloc] init];
	printf("new is %3.1f\n", [new duration]);
	printf("Estimation Accuracy set to +/- 0.10\n");
	Statistics *testStats = [[Statistics alloc] init: 40 accuracy: .10f count: 100];
	printf("\nResults for 40, .1, 100 are: %3.2f, %3.2f\n", [testStats mean], [testStats stdDev]);
    [testStats release];
	printf("Duration for mean = %3.2f\n", [new durationWithSigma: 0.0f]);
	printf("Duration for 1 sigma = %3.2f\n", [new durationWithSigma: 1.0f]);
	printf("Duration for 2 sigma = %3.2f\n", [new durationWithSigma: 2.0f]);
    [new release];
	
	// Test the Team and Resource classes
	Team *team1 = [[Team alloc] init: @"Shoulders"];
	[team1 addResource: [[Resource alloc] init: @"Tom" last:@"Love" phone:@"800-555-1212" imageName:@"Icon.png" started:[[NSDate alloc] init] 
										  role: @"PM" billout: 175.0f]];
	[team1 addResource: [[Resource alloc] init: @"John" last:@"Wooten" phone:@"865-300-4774" imageName:@"Icon.png" started:[[NSDate alloc] init] 
										  role: @"Arch" billout: 175.0f]];
	[team1 print];
	Project *project1 = [[Project alloc] init: @"PayXpert" client: @"ADP"];
	[project1 addTeam: team1];
	Team *team2 = [[Team alloc] init: @"ADP"];
	[team2 addResource: [[Resource alloc] init: @"Roger" last:@"Doofus" phone:@"800-555-1212" imageName:@"Icon.png" started:[[NSDate alloc] init] 
										  role: @"Dev" billout: 125.0f]];
	[team2 addResource: [[Resource alloc] init: @"Jenny" last:@"Gomez" phone:@"800-555-1212" imageName:@"Icon.png" started:[[NSDate alloc] init] 
										  role: @"GUI" billout: 80.0f]];
	[team2 print];
	[project1 addTeam: team2];
	[project1 print];
	[project1 removeTeam: team1];
	[project1 print];
	[project1 dealloc];	
     */
}
- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end

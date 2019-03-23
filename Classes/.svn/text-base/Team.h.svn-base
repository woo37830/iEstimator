//
//  Team.h
//  iEstimator
//
//  Created by John Wooten on 1/8/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resource.h"


@interface Team : NSObject {
	NSString *name;
	NSMutableArray *resources;

}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *resources;

-(id) init: (NSString *) aName;
- (NSString *)name;
- (void) addResource: (Resource *)aResource;
- (void) terminateResource: (Resource *)aResource onDate: (NSDate *)aDate;
- (int) resourceCount;
- (NSMutableArray *)resources;
- (Resource *)resourceAtIndex:(int)index;
- (float) teamPersonHours;
- (float) teamCost; // team cost at time requested.
- (float) teamCostAt: (NSDate *)aDate; // team cost as of aDate
- (void) print;
- (void) print: (NSArray *)array;
- (NSString *) description;
- (void) dealloc;
@end

//
//  Team.m
//  iEstimator
//
//  Team holds the resources and provides methods to calculate person-months of effort,
//  total costs, since resources are added incrementally to a project.
//
//  Created by John Wooten on 1/8/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "Team.h"


@implementation Team

@synthesize resources, name;

-(id) init: (NSString *) aName	{
	[super init];
	resources = [[NSMutableArray alloc] init];
	name = aName;
	return self;
}


- (NSString *)name	{
	return name;
}

- (void) addResource: (Resource *)aResource	{
	[resources addObject: aResource];
}

- (void) terminateResource: (Resource *)aResource onDate: (NSDate *)aDate	{
	// Look the resource up and set the endDate
}

- (int) resourceCount	{
	return [resources count];
}

- (Resource *)resourceAtIndex:(int)index	{
	return [resources objectAtIndex:index];
}

- (NSMutableArray *) resources	{
	return resources;
}

- (float) teamPersonHours	{
	return 0.0f;
}
- (float) teamCost	{ // use teamCostAt: with present date.
	return [self teamCostAt: [[NSDate alloc] init]];
}
- (float) teamCostAt: (NSDate *)aDate	{ // add up resources until this date.
	float total = 0.0f;
	NSEnumerator *enumerator = [resources objectEnumerator];
	Resource *aResource;
	
    while ( aResource = [enumerator nextObject] ) {
		total += [aResource totalCostAsOf:aDate];
	}
	return total;
}

-(void) print	{
	[self print: resources];
}

-(NSString *) description	{
	return [NSString stringWithFormat: @"Team: %@\t\tPerson Hours: %3.2f\tCost: %4.2f",name, [self teamPersonHours],[self teamCost]];
}
-(void) print: (NSArray *)array {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSString *tString = [self description];
	printf("%s\n", [[tString description] cStringUsingEncoding: [NSString defaultCStringEncoding]]);
    NSEnumerator *enumerator = [array objectEnumerator];
    id obj;
	
    while ( obj = [enumerator nextObject] ) {
        printf( "\t%s\n", [[obj description]cStringUsingEncoding: [NSString defaultCStringEncoding]] );
    }
	//[pool release];
}

- (void) dealloc	{
	/*[name release];
	[resources release];*/
	[super dealloc];
}

- (id) initWithCoder:(NSCoder *)decoder
{
	if( self = [super init] )
	{
		self.name = [decoder decodeObjectForKey:@"teamName"];
		self.resources = [decoder decodeObjectForKey:@"resources"];
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *) encoder
{
	[encoder encodeObject:[self name] forKey:@"teamName"];
	[encoder encodeObject:resources forKey:@"resources"];
}	

@end

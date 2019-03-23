//
//  Project.m
//  iEstimator
//
//  Created by John Wooten on 1/7/09.
//  Copyright 2009 ShouldersCorp.. All rights reserved.
//

#import "Project.h"
#import "Team.h"
#import "Utilities.h"
#import "EstimationModel.h"


@implementation Project

@synthesize proposedStart, predictedEnd, actualStart, actualEnd, teams;

- (id) init: (NSString *)aName client: (NSString *)aClient	{
	[super init];
	[self setName:aName];
	printf("\nProject '%s' created",[[self name] UTF8String]);
	client = aClient;
	teams = [[NSMutableArray alloc] init];
	model = [[EstimationModel alloc] initWithName:@"Default Model"];


	actualCostValue = -1.0f;
	return self;
}

- (void) setName:(NSString *)aName	{
	[aName retain];
	//[name release];
	name = aName;
}
- (NSString *) name	{
	return name;
}
- (void) setClient:(NSString *)aClient	{
	[aClient retain];
	//[client release];
	client = aClient;
}
- (NSString *) client	{
	return client;
}

- (void) setProposedStart:(NSDate *)aDate
{
	[aDate retain];
	[proposedStart release];
	proposedStart = aDate;
}

- (NSString *)proposedStartStr	{
	NSString *retVal = [Utilities dateToDateStr:[self proposedStart]];
	return retVal;
}

- (void) setPredictedEnd:(NSDate *)aDate
{
	[aDate retain];
	//[predictedEnd release];
	predictedEnd = aDate;
}

- (NSDate *)predictedEnd	{
	NSDate *start = [self proposedStart];
	if( [self actualStart] != nil )
		start = [self actualStart];
	if( start != nil )	{
		float dur = [model duration];
		int years = (int)dur/12.0f; // e.g. 13.7, yrs = 1
		int months = (int)(dur - (years*12.0f)); // e.g. 13.7, months = 1
		int days = (int)((dur - years*12.0f - months*1.0f)*30.0f);
		printf("\npredicted End is %d years, %d months, %d days away from %s",years, months, days, [[start description] UTF8String]);
		[self setPredictedEnd:[Utilities adjustDate: start byYear:years months: months days: days]];
	}
	return predictedEnd;
}
- (NSString *)predictedEndStr	{
	return [Utilities dateToDateStr:[self predictedEnd]];
}

- (void)setActualStart:(NSDate *)aDate
{
	[aDate retain];
	//[actualStart release];
	actualStart = aDate;
	printf("\nProject actualStart has been set to %s",[[actualStart description] UTF8String]);
}

- (NSString *) actualCostValue
{
	return [NSString stringWithFormat: @"%6.0f",
			actualCostValue];
}

- (NSString *) actualCostStr
{
	return [NSString stringWithFormat: @"$%6.0f     ",
			actualCostValue];
}
- (NSDate *)actualStart
{
	return actualStart;
}

- (NSString *)actualStartStr	{
	return [Utilities dateToDateStr:[self actualStart]];
}

- (void)setActualEnd:(NSDate *)aDate
{
	[aDate retain];
	//[actualEnd release];
	actualEnd = aDate;
}

- (NSDate *)actualEnd
{
	return actualEnd;
}

- (NSString *)actualEndStr	{
	return [Utilities dateToDateStr:[self actualEnd]];
}

- (float) actualDuration	{
	float actualDuration = 0.0f;
	if( [self actualStart] != nil )	{
        NSDate *theDate = nil;
        BOOL releaseDate = false;
		if( [self actualEnd] != nil )	{ // calculate actual duration
			theDate = [self actualEnd];
		} else	{ // return as of today if today is after actual start
			theDate = [[NSDate alloc] init]; // today
            releaseDate = true;
		}
		int years = [Utilities yearsBetweenStartDate:[self actualStart] endDate:theDate];
		int months = [Utilities monthsBetweenStartDate:[self actualStart] endDate:theDate];
		int days = [Utilities daysBetweenStartDate:[self actualStart] endDate:theDate];
		actualDuration = years * 12.0f + months + days/30.0f;
		if( actualDuration < 0.0f )
				actualDuration = 0.0f;
        if( releaseDate )   {
            //[theDate release];
        }
	}
	return actualDuration;
}

- (void) setActualCost:(NSString *)str	{
	float val = -1.0f;
	if( ![str isEqualToString:@"-1"] )	{
		printf("\n str = '%s' is not equal to -1",[str UTF8String]);
	    val = [str floatValue];
	   } 
	printf("\nSetting actualCostValue to %f",val);
	actualCostValue = val;
	//[str release];
}

- (float) actualCost	{ // if the teams integrated total cost > 0 return that , else the set value 
	printf("\nCalculate the projects actual cost\n");
	float val = -1.0f;
	if( actualCostValue != val )	{
		printf("\nReturning actualCostValue since it has been set\n");
		return actualCostValue;
	} else	{
		printf("\nThe actualCost value = %f", actualCostValue);
	}
	printf("\nCalculating team contributions\n");
	if( teams == nil )
		return actualCostValue;
	//printf("\nNumber of teams = %s",[teams count]);
	float total = 0.0f; // This will be used when teams are added
	int i = 0;
    for( i = 0; i<[teams count]; i++ ) {
		Team *team = [teams objectAtIndex:i];
		//[team print];
		if( [self actualEnd] == nil )	{
			total += [team teamCost];
		} else	{
			total += [team teamCostAt:[self actualEnd]];
		}
	}
	if( total == 0.0f )	{
		printf("\nTeam costs summed to 0");
		return [self percentComplete]*[model totalCost]/100.0f;
	}
	else
		return total;
}

- (float) percentComplete	{
	return ([self actualDuration]/[model duration])*100.0f;
}

- (float) percentCost	{
	return ([self actualCost]/[model totalCost]) * 100.0f;
}
- (void) update	{
	printf("\n update the project data from the model data");
}
- (void) addTeam: (Team *)aTeam	{
	[teams addObject: aTeam];
}
- (void) removeTeam: (Team *)aTeam	{
	[teams removeObject:aTeam];
}

- (void) setModel:(EstimationModel *)aModel	{ // set the default model from the set of models.
	[aModel retain];
	//[model release];
	model = aModel;
	printf("\nModel was reset");
}
- (EstimationModel *) model	{ // this is the default model
	return model;
}

- (Team *) teamAtIndex:(int) index	{
	return [teams objectAtIndex:index];
}

- (Team *) teamForName:(NSString *) teamName	{
	int i = 0;
	for( i = 0; i< [teams count]; i++ )
	{
		Team *aTeam = [teams objectAtIndex:i];
		if( [aTeam name] == teamName )
			return aTeam;
	}
	return nil;
}
- (NSMutableArray *) teams	{
	return teams;
}

- (void) print: (NSMutableArray *)anArray
{
	if( anArray == nil )
		return;
	int i = 0;
	for( i = 0; i< [anArray count]; i++ )
	{
		id obj = [anArray objectAtIndex: i];
		[obj print];
	}
}

- (void) print	
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSString *tString = [NSString stringWithFormat: @"Project: %@ \n\tClient: %@\n\tProjected Duration: %3.1f mo. \n\tProjected Cost: $%4.2f",name, client,[model duration],[model totalCost] ];
	
	printf("\n%s\n", [tString UTF8String]);
	[self print: teams];
	//[pool release];	
}

- (void) dealloc	{
	/*[name release];
	[client release];
	[proposedStart release];
	[predictedEnd release];
	[actualStart release];
	[actualEnd release];
	[teams release];
	[model release];*/
	[super dealloc];
}

- (id) initWithCoder:(NSCoder *)decoder
{
	if( self = [super init] )
	{
		[self setName:[decoder decodeObjectForKey:@"projectName"]];
		[self setClient: [decoder decodeObjectForKey:@"projectClient"]];
		[self setProposedStart:[Utilities dateStrToDate:[decoder decodeObjectForKey:@"proposedStart"]]];
		[self setPredictedEnd:[Utilities dateStrToDate:[decoder decodeObjectForKey:@"predictedEnd"]]];
		[self setActualStart:[Utilities dateStrToDate:[decoder decodeObjectForKey:@"actualStart"]]];
		[self setActualEnd:[Utilities dateStrToDate:[decoder decodeObjectForKey:@"actualEnd"]]];
		//[self setActualCost:[[decoder decodeObjectForKey:@"actualCost"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		//printf("\nThe read in value for actual Cost is '%f'", [self actualCost]);
		[self setModel:[decoder decodeObjectForKey:@"model"]];
		[self setTeams:[decoder decodeObjectForKey:@"teams"]];
		printf("\nProject has decoded '%s' - '%s'",[[self name] UTF8String], [[self client] UTF8String]);
		printf("\nAnother line printed");
	}
	return self;
}

- (void) encodeWithCoder:(NSCoder *) encoder
{
	[encoder encodeObject:[self name] forKey:@"projectName"];
	[encoder encodeObject:[self client] forKey:@"projectClient"];
	[encoder encodeObject:[self proposedStartStr] forKey:@"proposedStart"];
	[encoder encodeObject:[self predictedEndStr] forKey:@"predictedEnd"];
	[encoder encodeObject:[self actualStartStr] forKey:@"actualStart"];
	[encoder encodeObject:[self actualEndStr] forKey:@"actualEnd"];
	//printf("\nThe written value of actual cost str is '%s'", [[self actualCostValue] UTF8String]);
	//[encoder encodeObject:[self actualCostValue] forKey:@"actualCost"];
	[encoder encodeObject:[self model] forKey:@"model"];
	[encoder encodeObject:[self teams] forKey:@"teams"];
	printf("\nProject has encoded %s - %s",[[self name] UTF8String],[[self client] UTF8String]);
}


@end
